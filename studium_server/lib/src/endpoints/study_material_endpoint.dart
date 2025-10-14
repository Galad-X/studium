// lib/src/endpoints/study_material_endpoint.dart
import 'dart:typed_data';
import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';
import 'package:xml/xml.dart';
import 'package:docx_template_fork/docx_template_fork.dart';

import '../generated/protocol.dart';
import '../services/aws_s3_service.dart';
import '../util/endpoint_utils.dart';

class StudyMaterialEndpoint extends Endpoint with EndpointUtils {
  @override
  bool get requireLogin => true;

  /// Upload study material
  Future<StudyMaterial> uploadMaterial(Session session, String title,
      String fileType, ByteData? fileData, String? fileUrl) async {
    final userId = await getAuthenticatedUserId(session);

    // Validate input
    if (title.trim().isEmpty) {
      throw Exception('Title cannot be empty');
    }

    final supportedTypes = [
      'pdf',
      'docx',
      'pptx',
      'txt',
      'md',
      'doc',
      'ppt',
      'xlsx'
    ];
    if (!supportedTypes.contains(fileType.toLowerCase())) {
      throw Exception('Unsupported file type: $fileType');
    }

    // Check user limits
    final isPremium = await isPremiumUser(session, userId);
    final existingMaterials = await StudyMaterial.db
        .find(session, where: (t) => t.userId.equals(userId));

    final maxMaterials = isPremium ? 1000 : 50;
    if (existingMaterials.length >= maxMaterials) {
      throw Exception(
          'Maximum number of materials reached (${isPremium ? 'Premium' : 'Free'}: $maxMaterials)');
    }

    // Check file size for premium users
    if (fileData != null) {
      final maxSizeMB = isPremium ? 100 : 50;
      final maxSizeBytes = maxSizeMB * 1024 * 1024;
      if (fileData.lengthInBytes > maxSizeBytes) {
        throw Exception('File size too large. Maximum: ${maxSizeMB}MB');
      }
    }

    try {
      // Upload file to storage if fileData is provided
      String storedFileUrl;
      if (fileData != null) {
        final s3service = AwsS3Service.fromConfig(session.serverpod);
        final bytes = fileData.buffer.asUint8List();
        final contentType = _getContentType(fileType);

        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final sanitizedTitle =
            title.replaceAll(RegExp(r'[^a-zA-Z0-9\-_]'), '_');
        final objectKey =
            'uploads/$userId/${timestamp}_$sanitizedTitle.$fileType';
        // Call the service to upload the file
        storedFileUrl =
            await s3service.uploadFile(objectKey, bytes, contentType);
      } else if (fileUrl != null) {
        storedFileUrl = fileUrl;
      } else {
        throw Exception('Either file data or file URL must be provided');
      }

      // Create study material record
      final material = StudyMaterial(
        userId: userId,
        title: title,
        fileType: fileType.toLowerCase(),
        fileUrl: storedFileUrl,
        uploadDate: DateTime.now(),
        size: fileData?.lengthInBytes,
      );
      final savedMaterial = await StudyMaterial.db.insertRow(session, material);

      // Create file processing record
      final fileProcessing = FileProcessing(
        studyMaterialId: savedMaterial.id!,
        status: 'pending',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await FileProcessing.db.insertRow(session, fileProcessing);

      // Update study history
      await _updateStudyHistory(session, userId,
          materialIds: [savedMaterial.id!]);

      // Start background processing
      _scheduleFileProcessing(savedMaterial.id!);

      return savedMaterial;
    } catch (e) {
      print('Error uploading material: $e');
      throw Exception('Failed to upload material: ${e.toString()}');
    }
  }

  /// Get all materials for authenticated user
  Future<List<StudyMaterial>> getMaterials(Session session) async {
    final userId = await getAuthenticatedUserId(session);

    try {
      return await StudyMaterial.db.find(
        session,
        where: (t) => t.userId.equals(userId),
        orderBy: (t) => t.uploadDate,
        orderDescending: true,
      );
    } catch (e) {
      print('Error fetching materials: $e');
      throw Exception('Failed to fetch materials');
    }
  }

  /// Get sample material for demo purposes
  Future<StudyMaterial> getSampleMaterial(Session session) async {
    try {
      var sample = await StudyMaterial.db.findFirstRow(session,
          where: (t) => t.title.equals('Sample Material'));

      if (sample == null) {
        // Create sample material if it doesn't exist
        sample = StudyMaterial(
          userId: 0, // System user
          title: 'Sample Material',
          fileType: 'pdf',
          fileUrl: 'https://example.com/sample.pdf',
          uploadDate: DateTime.now(),
          size: 1024000, // 1MB
          contentText: '''
          Sample Educational Content
          
          This is a sample document about photosynthesis. Photosynthesis is the process by which 
          green plants and some other organisms use sunlight to synthesize foods with the help of 
          chlorophyll. During this process, plants convert carbon dioxide and water into glucose 
          and oxygen.
          
          The equation for photosynthesis is: 6CO2 + 6H2O + light energy → C6H12O6 + 6O2
          
          This process occurs in two main stages:
          1. Light-dependent reactions (occur in the thylakoids)
          2. Calvin cycle (occurs in the stroma)
          
          Key Points:
          - Chlorophyll absorbs light energy
          - Water molecules are split to release oxygen
          - Carbon dioxide is fixed into organic molecules
          - ATP and NADPH are produced and consumed
          ''',
        );
        sample = await StudyMaterial.db.insertRow(session, sample);
      }

      return sample;
    } catch (e) {
      print('Error getting sample material: $e');
      throw Exception('Failed to get sample material');
    }
  }

  /// Delete a study material
  Future<void> deleteMaterial(Session session, int materialId) async {
    final userId = await getAuthenticatedUserId(session);

    try {
      final material = await StudyMaterial.db.findById(session, materialId);
      if (material == null || material.userId != userId) {
        throw Exception('Material not found or unauthorized');
      }

      try {
        final s3service = AwsS3Service.fromConfig(session.serverpod);
        final objectKey = Uri.parse(material.fileUrl).path.substring(1);
        await s3service.deleteFile(objectKey);
      } catch (e) {
        // Log the error but don't prevent the database record from being deleted
        session.log(
            'Failed to delete file from S3, but proceeding with DB deletion. Error: $e',
            level: LogLevel.warning);
      }

      // Delete related records first
      await FileProcessing.db.deleteWhere(session,
          where: (t) => t.studyMaterialId.equals(materialId));

      await Question.db.deleteWhere(session,
          where: (t) => t.studyMaterialId.equals(materialId));

      await Summary.db.deleteWhere(session,
          where: (t) => t.studyMaterialId.equals(materialId));

      // Delete the material
      await StudyMaterial.db.deleteRow(session, material);
    } catch (e) {
      print('Error deleting material: $e');
      throw Exception('Failed to delete material: ${e.toString()}');
    }
  }

  /// Update study material metadata
  Future<StudyMaterial> updateMaterial(Session session, int materialId,
      String? title, Map<String, dynamic>? metadata) async {
    final userId = await getAuthenticatedUserId(session);

    try {
      final material = await StudyMaterial.db.findById(session, materialId);
      if (material == null || material.userId != userId) {
        throw Exception('Material not found or unauthorized');
      }

      final updatedMaterial = material.copyWith(
        title: title ?? material.title,
        // Add other metadata fields as needed
      );

      return await StudyMaterial.db.updateRow(session, updatedMaterial);
    } catch (e) {
      print('Error updating material: $e');
      throw Exception('Failed to update material: ${e.toString()}');
    }
  }

  /// Get processing status of a material
  Future<FileProcessing?> getProcessingStatus(
      Session session, int materialId) async {
    final userId = await getAuthenticatedUserId(session);

    try {
      // Verify user owns the material
      final material = await StudyMaterial.db.findById(session, materialId);
      if (material == null || material.userId != userId) {
        throw Exception('Material not found or unauthorized');
      }

      return await FileProcessing.db.findFirstRow(
        session,
        where: (t) => t.studyMaterialId.equals(materialId),
      );
    } catch (e) {
      print('Error getting processing status: $e');
      return null;
    }
  }

  /// Get materials by file type (for authenticated user)
  Future<List<StudyMaterial>> getMaterialsByType(
      Session session, String fileType) async {
    final userId = await getAuthenticatedUserId(session);

    try {
      return await StudyMaterial.db.find(
        session,
        where: (t) =>
            t.userId.equals(userId) & t.fileType.equals(fileType.toLowerCase()),
        orderBy: (t) => t.uploadDate,
        orderDescending: true,
      );
    } catch (e) {
      print('Error fetching materials by type: $e');
      return [];
    }
  }

  /// Search materials by title
  Future<List<StudyMaterial>> searchMaterials(
      Session session, String query) async {
    final userId = await getAuthenticatedUserId(session);

    if (query.trim().isEmpty) {
      return await getMaterials(session);
    }

    try {
      return await StudyMaterial.db.find(
        session,
        where: (t) =>
            t.userId.equals(userId) & t.title.like('%${query.toLowerCase()}%'),
        orderBy: (t) => t.uploadDate,
        orderDescending: true,
      );
    } catch (e) {
      print('Error searching materials: $e');
      return [];
    }
  }

  /// Get material statistics for user
  Future<Map<String, dynamic>> getMaterialStats(Session session) async {
    try {
      final materials = await getMaterials(session);
      final typeCount = <String, int>{};
      int totalSize = 0;

      for (final material in materials) {
        typeCount[material.fileType] = (typeCount[material.fileType] ?? 0) + 1;
        if (material.size != null) {
          totalSize += material.size!;
        }
      }

      return {
        'totalMaterials': materials.length,
        'totalSize': totalSize,
        'typeDistribution': typeCount,
        'averageSize': materials.isNotEmpty ? totalSize / materials.length : 0,
        'lastUpload': materials.isNotEmpty
            ? materials.first.uploadDate.toIso8601String()
            : null,
      };
    } catch (e) {
      print('Error getting material stats: $e');
      return {
        'totalMaterials': 0,
        'totalSize': 0,
        'typeDistribution': <String, int>{},
        'averageSize': 0,
        'lastUpload': null,
      };
    }
  }

  /// Schedule file processing with proper background task management
  void _scheduleFileProcessing(int materialId) {
    // Schedule background processing
    Future.microtask(() => _processFileInBackground(materialId));
  }

  /// Background file processing with session management
  Future<void> _processFileInBackground(int materialId) async {
    // Create a background session for database operations
    final backgroundSession = await createBackgroundSession();

    try {
      // Update status to processing
      await _updateProcessingStatus(
          backgroundSession, materialId, 'processing');

      // Get the material
      final material =
          await StudyMaterial.db.findById(backgroundSession, materialId);
      if (material == null) {
        throw Exception('Material not found');
      }

      // Process the file
      final processedContent = await _processFile(material);

      // Update the material with extracted content
      final updatedMaterial = material.copyWith(
        contentText: processedContent.extractedText,
      );
      await StudyMaterial.db.updateRow(backgroundSession, updatedMaterial);

      // Update processing record
      final processing = await FileProcessing.db.findFirstRow(
        backgroundSession,
        where: (t) => t.studyMaterialId.equals(materialId),
      );

      if (processing != null) {
        final updatedProcessing = processing.copyWith(
          status: 'completed',
          processedText: processedContent.extractedText,
          updatedAt: DateTime.now(),
        );
        await FileProcessing.db.updateRow(backgroundSession, updatedProcessing);
      }

      // // Generate AI content
      // await _generateAIContent(
      //     backgroundSession, material, processedContent.extractedText);

      print('File processing completed for material ID: $materialId');

      // Optionally send notification to user
      await _sendProcessingNotification(
          backgroundSession, material.userId, materialId, 'completed');
    } catch (e) {
      print('Error processing file: $e');

      // Update status to failed
      await _updateProcessingStatus(backgroundSession, materialId, 'failed',
          errorMessage: e.toString());

      // Send failure notification
      final material =
          await StudyMaterial.db.findById(backgroundSession, materialId);
      if (material != null) {
        await _sendProcessingNotification(
            backgroundSession, material.userId, materialId, 'failed');
      }
    } finally {
      // Close background session
      await backgroundSession.close();
    }
  }

  /// Create a background session for database operations
  Future<Session> createBackgroundSession() async {
    // In Serverpod, you typically get sessions from the server instance
    // This is a simplified example - adjust based on your Serverpod setup
    final server = Serverpod.instance; // Adjust this based on your setup
    return await server.createSession(enableLogging: false);
  }

  /// Update processing status in database
  Future<void> _updateProcessingStatus(
      Session session, int materialId, String status,
      {String? errorMessage}) async {
    try {
      final processing = await FileProcessing.db.findFirstRow(
        session,
        where: (t) => t.studyMaterialId.equals(materialId),
      );

      if (processing != null) {
        final updatedProcessing = processing.copyWith(
          status: status,
          errorMessage: errorMessage,
          updatedAt: DateTime.now(),
        );
        await FileProcessing.db.updateRow(session, updatedProcessing);
      }
    } catch (e) {
      print('Error updating processing status: $e');
    }
  }

  /// Process individual file - extract text based on file type
  Future<FileProcessingResult> _processFile(StudyMaterial material) async {
    try {
      String extractedText = '';

      switch (material.fileType.toLowerCase()) {
        case 'pdf':
          extractedText = await _extractTextFromPDF(material.fileUrl);
          break;
        case 'docx':
          extractedText = await _extractTextFromDocx(material.fileUrl);
          break;
        case 'pptx':
          extractedText = await _extractTextFromPptx(material.fileUrl);
          break;
        case 'ppt':
          extractedText = await _extractTextFromPpt(material.fileUrl);
          break;
        case 'txt':
        case 'md':
          extractedText = await _extractTextFromPlainText(material.fileUrl);
          break;
        case 'xlsx':
          extractedText = await _extractTextFromExcel(material.fileUrl);
          break;
        default:
          throw Exception('Unsupported file type: ${material.fileType}');
      }

      return FileProcessingResult(
        extractedText: extractedText,
        wordCount: extractedText.split(' ').length,
        keyPhrases: _extractKeyPhrases(extractedText),
      );
    } catch (e) {
      throw Exception('Failed to process file: $e');
    }
  }

  /// Extract text from PDF file
  /// Extract text from PDF file using basic PDF parsing
  Future<String> _extractTextFromPDF(String fileUrl) async {
    try {
      // Download the PDF file
      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to download PDF file: ${response.statusCode}');
      }

      // Parse PDF content using basic text extraction
      final extractedText = _parseBasicPDFText(response.bodyBytes);

      if (extractedText.trim().isEmpty) {
        return 'PDF file appears to be empty or contains no extractable text (e.g., it might be an image-only PDF).';
      }

      return _cleanExtractedText(extractedText);
    } catch (e) {
      print('Error extracting PDF text: $e');
      return 'Failed to process PDF file. Please ensure it is a valid PDF. Error: ${e.toString()}';
    }
  }

  String _parseBasicPDFText(Uint8List pdfBytes) {
    try {
      // Convert bytes to string for pattern matching
      final pdfContent = String.fromCharCodes(pdfBytes);
      final textBuffer = StringBuffer();

      // Look for text content between BT (Begin Text) and ET (End Text) markers
      final btEtRegex =
          RegExp(r'BT\s*(.*?)\s*ET', multiLine: true, dotAll: true);
      final btEtMatches = btEtRegex.allMatches(pdfContent);

      for (final match in btEtMatches) {
        final textBlock = match.group(1);
        if (textBlock != null) {
          final extractedText = _extractTextFromBlock(textBlock);
          if (extractedText.isNotEmpty) {
            textBuffer.writeln(extractedText);
          }
        }
      }

      // Also look for simple text patterns with Tj and TJ operators
      _extractDirectTextOperators(pdfContent, textBuffer);

      return textBuffer.toString();
    } catch (e) {
      print('Error parsing PDF content: $e');
      return '';
    }
  }

  /// Extract text from a text block between BT/ET markers
  String _extractTextFromBlock(String textBlock) {
    final textBuffer = StringBuffer();

    // Pattern for text strings with Tj operator: (text) Tj
    final tjRegex = RegExp(r'\((.*?)\)\s*Tj', multiLine: true);
    final tjMatches = tjRegex.allMatches(textBlock);

    for (final match in tjMatches) {
      final text = match.group(1);
      if (text != null) {
        final decodedText = _decodePDFString(text);
        if (decodedText.trim().isNotEmpty) {
          textBuffer.write(decodedText);
          textBuffer.write(' ');
        }
      }
    }

    // Pattern for text arrays with TJ operator: [(text) adjustments] TJ
    final tjArrayRegex = RegExp(r'\[\s*(.*?)\s*\]\s*TJ', multiLine: true);
    final tjArrayMatches = tjArrayRegex.allMatches(textBlock);

    for (final match in tjArrayMatches) {
      final arrayContent = match.group(1);
      if (arrayContent != null) {
        // Extract text from array elements
        final textInArrayRegex = RegExp(r'\((.*?)\)');
        final arrayTextMatches = textInArrayRegex.allMatches(arrayContent);

        for (final textMatch in arrayTextMatches) {
          final text = textMatch.group(1);
          if (text != null) {
            final decodedText = _decodePDFString(text);
            if (decodedText.trim().isNotEmpty) {
              textBuffer.write(decodedText);
              textBuffer.write(' ');
            }
          }
        }
      }
    }

    return textBuffer.toString().trim();
  }

  /// Extract text using direct Tj/TJ operators (fallback method)
  void _extractDirectTextOperators(String pdfContent, StringBuffer textBuffer) {
    // Look for standalone Tj operators
    final tjRegex = RegExp(r'\((.*?)\)\s*Tj', multiLine: true);
    final tjMatches = tjRegex.allMatches(pdfContent);

    final Set<String> processedTexts = <String>{};

    for (final match in tjMatches) {
      final text = match.group(1);
      if (text != null) {
        final decodedText = _decodePDFString(text);
        if (decodedText.trim().isNotEmpty &&
            !processedTexts.contains(decodedText)) {
          processedTexts.add(decodedText);
          textBuffer.write(decodedText);
          textBuffer.write(' ');
        }
      }
    }

    // Look for TJ array operators
    final tjArrayRegex = RegExp(r'\[\s*(.*?)\s*\]\s*TJ', multiLine: true);
    final tjArrayMatches = tjArrayRegex.allMatches(pdfContent);

    for (final match in tjArrayMatches) {
      final arrayContent = match.group(1);
      if (arrayContent != null) {
        final textInArrayRegex = RegExp(r'\((.*?)\)');
        final arrayTextMatches = textInArrayRegex.allMatches(arrayContent);

        for (final textMatch in arrayTextMatches) {
          final text = textMatch.group(1);
          if (text != null) {
            final decodedText = _decodePDFString(text);
            if (decodedText.trim().isNotEmpty &&
                !processedTexts.contains(decodedText)) {
              processedTexts.add(decodedText);
              textBuffer.write(decodedText);
              textBuffer.write(' ');
            }
          }
        }
      }
    }
  }

  /// Decode PDF string (handle escape sequences and encoding)
  String _decodePDFString(String text) {
    return text
        // Handle common PDF escape sequences
        .replaceAll('\\n', '\n')
        .replaceAll('\\r', '\r')
        .replaceAll('\\t', '\t')
        .replaceAll('\\b', '\b')
        .replaceAll('\\f', '\f')
        .replaceAll('\\(', '(')
        .replaceAll('\\)', ')')
        .replaceAll('\\\\', '\\')
        // Handle octal escape sequences
        .replaceAllMapped(RegExp(r'\\([0-7]{1,3})'), (match) {
      try {
        final octalValue = int.parse(match.group(1)!, radix: 8);
        if (octalValue <= 255) {
          return String.fromCharCode(octalValue);
        }
      } catch (e) {
        // If parsing fails, return the original
      }
      return match.group(0)!;
    });
  }

  /// Extract text from Word document
  Future<String> _extractTextFromDocx(String fileUrl) async {
    try {
      // Download the file
      final fileBytes = await _downloadFile(fileUrl);

      // Use docx_template_fork to read the document
      final docx = await DocxTemplate.fromBytes(fileBytes);

      // Extract text content
      final extractedText = await _extractTextFromDocxTemplate(docx);

      if (extractedText.trim().isEmpty) {
        return 'DOCX file appears to be empty or contains no extractable text.';
      }

      return _cleanExtractedText(extractedText);
    } catch (e) {
      print('Error extracting DOCX text: $e');
      return 'Error extracting text from DOCX file. Please ensure the file is not corrupted. Error: ${e.toString()}';
    }
  }

  /// Downloads file from URL and returns bytes
  Future<Uint8List> _downloadFile(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to download file: HTTP ${response.statusCode}');
    }

    return response.bodyBytes;
  }

  /// Extracts text from DocxTemplate object
  Future<String> _extractTextFromDocxTemplate(DocxTemplate docx) async {
    try {
      final content =
          docx.toString(); 
      return content;
    } catch (e) {
      throw Exception('Failed to extract text from DOCX template: $e');
    }
  }

  Future<String> _extractTextFromPptx(String fileUrl) async {
    try {
      // Download the PPTX file
      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to download PPTX file: ${response.statusCode}');
      }

      // Extract using archive parsing (improved version)
      final bytes = response.bodyBytes;
      final archive = ZipDecoder().decodeBytes(bytes);

      final extractedText = StringBuffer();
      int slideNumber = 1;

      // Find all slide XML files
      final slideFiles = archive.files
          .where((file) =>
              file.name.startsWith('ppt/slides/slide') &&
              file.name.endsWith('.xml'))
          .toList();

      // Sort slides by number
      slideFiles.sort((a, b) {
        final aNum = _extractSlideNumber(a.name);
        final bNum = _extractSlideNumber(b.name);
        return aNum.compareTo(bNum);
      });

      for (final slideFile in slideFiles) {
        final xmlContent = utf8.decode(slideFile.content);
        final document = XmlDocument.parse(xmlContent);

        extractedText.writeln('Slide $slideNumber:');
        extractedText.writeln('=' * 20);

        // Extract text from all text elements with better structure preservation
        final textNodes = document.findAllElements('a:t');
        final slideTexts = <String>[];

        for (final node in textNodes) {
          final text = node.value!.trim();
          if (text.isNotEmpty && !slideTexts.contains(text)) {
            slideTexts.add(text);
          }
        }

        // Also extract from ph (placeholder) elements
        final placeholderNodes = document.findAllElements('a:p');
        for (final pNode in placeholderNodes) {
          final pTexts = pNode.findAllElements('a:t');
          for (final tNode in pTexts) {
            final text = tNode.value!.trim();
            if (text.isNotEmpty && !slideTexts.contains(text)) {
              slideTexts.add(text);
            }
          }
        }

        if (slideTexts.isNotEmpty) {
          for (final text in slideTexts) {
            extractedText.writeln('• $text');
          }
        } else {
          extractedText.writeln('• [No text content]');
        }

        extractedText.writeln();
        slideNumber++;
      }

      final result = extractedText.toString().trim();
      if (result.isEmpty) {
        return 'PPTX file appears to be empty or contains no extractable text.';
      }

      return _cleanExtractedText(result);
    } catch (e) {
      print('Error extracting PPTX text: $e');
      return 'Error extracting text from PPTX file. Please ensure the file is not corrupted. Error: ${e.toString()}';
    }
  }

  /// Extract text from plain text files
  Future<String> _extractTextFromPlainText(String fileUrl) async {
    try {
      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode == 200) {
        // Try UTF-8 first, then fallback to Latin-1 if needed
        try {
          return utf8.decode(response.bodyBytes);
        } catch (e) {
          return latin1.decode(response.bodyBytes, allowInvalid: true);
        }
      } else {
        throw Exception('Failed to fetch text file: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error reading text file: $e');
    }
  }

  Future<String> _extractTextFromPpt(String fileUrl) async {
    try {
      // Download the PPT file
      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to download PPT file: ${response.statusCode}');
      }

      // Try to extract readable text from binary PPT data
      final extractedText = _extractTextFromBinaryPpt(response.bodyBytes);

      if (extractedText.trim().isEmpty) {
        return 'Unable to extract text from this PPT file. Please convert to PPTX format for better compatibility.';
      }

      return _cleanExtractedText(extractedText);
    } catch (e) {
      print('Error extracting PPT text: $e');
      return 'Error processing PPT file. Please convert to PPTX format for better compatibility. Error: ${e.toString()}';
    }
  }

  /// Fallback method to extract text from binary PPT files
  String _extractTextFromBinaryPpt(List<int> bytes) {
    try {
      // Convert bytes to string and look for readable text patterns
      final content = latin1.decode(bytes, allowInvalid: true);

      // PowerPoint files often have text preceded by specific markers
      final textBuffer = StringBuffer();
      final chunks =
          content.split(RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F\x7F-\xFF]+'));

      // int slideNumber = 1;
      final processedTexts = <String>{};

      for (final chunk in chunks) {
        final cleanChunk = chunk
            .replaceAll(RegExp(r'[^\x20-\x7E\n\r\t]'), ' ')
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim();

        // Look for substantial text content
        if (cleanChunk.length > 15 &&
            cleanChunk.contains(RegExp(r'[a-zA-Z]{4,}')) &&
            !processedTexts.contains(cleanChunk)) {
          // Filter out common PowerPoint metadata
          if (!_isPptMetadata(cleanChunk)) {
            textBuffer.writeln('• $cleanChunk');
            processedTexts.add(cleanChunk);
          }
        }
      }

      if (textBuffer.isNotEmpty) {
        return 'Extracted Content:\n${textBuffer.toString()}';
      }

      return '';
    } catch (e) {
      throw Exception('Failed to extract text from PPT file: $e');
    }
  }

  bool _isPptMetadata(String text) {
    final metadataPatterns = [
      'Microsoft Office PowerPoint',
      'Slide Master',
      'Title Master',
      'Handout Master',
      'Notes Master',
      'PowerPoint Document',
      RegExp(r'^[A-Z]{2,}\s*$'), // All caps short strings
      RegExp(r'^\d+$'), // Just numbers
      RegExp(r'^[^\w\s]+$'), // Just symbols
    ];

    for (final pattern in metadataPatterns) {
      if (pattern is String && text.contains(pattern)) {
        return true;
      } else if (pattern is RegExp && pattern.hasMatch(text)) {
        return true;
      }
    }

    return false;
  }

  /// Extract text from Excel file
  Future<String> _extractTextFromExcel(String fileUrl) async {
    try {
      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to download Excel file: ${response.statusCode}');
      }

      final bytes = response.bodyBytes;
      final archive = ZipDecoder().decodeBytes(bytes);

      // Extract shared strings with better error handling
      final sharedStringsFile = archive.findFile('xl/sharedStrings.xml');
      final sharedStrings = <String>[];

      if (sharedStringsFile != null) {
        try {
          final document =
              XmlDocument.parse(utf8.decode(sharedStringsFile.content));
          document.findAllElements('si').forEach((siElement) {
            final textBuffer = StringBuffer();

            // Handle rich text runs
            final rElements = siElement.findAllElements('r');
            if (rElements.isNotEmpty) {
              for (final rElement in rElements) {
                final tElements = rElement.findAllElements('t');
                for (final tElement in tElements) {
                  textBuffer.write(tElement.value);
                }
              }
            } else {
              // Handle simple text
              final tElements = siElement.findAllElements('t');
              for (final tElement in tElements) {
                textBuffer.write(tElement.value);
              }
            }

            sharedStrings.add(textBuffer.toString());
          });
        } catch (e) {
          print('Error parsing shared strings: $e');
        }
      }

      final extractedText = StringBuffer();

      // Process worksheets with better error handling
      final sheetFiles = archive.files
          .where((file) => file.name.startsWith('xl/worksheets/sheet'))
          .toList();
      sheetFiles.sort((a, b) => a.name.compareTo(b.name));

      // Get worksheet names from workbook.xml
      final workbookFile = archive.findFile('xl/workbook.xml');
      final sheetNames = <String>[];

      if (workbookFile != null) {
        try {
          final workbookDoc =
              XmlDocument.parse(utf8.decode(workbookFile.content));
          workbookDoc.findAllElements('sheet').forEach((sheetElement) {
            final name = sheetElement.getAttribute('name');
            if (name != null) {
              sheetNames.add(name);
            }
          });
        } catch (e) {
          print('Error parsing workbook: $e');
        }
      }

      // Process each worksheet
      for (int i = 0; i < sheetFiles.length; i++) {
        final sheetFile = sheetFiles[i];
        final sheetName =
            i < sheetNames.length ? sheetNames[i] : 'Sheet ${i + 1}';

        try {
          final sheetXml = utf8.decode(sheetFile.content);
          final sheetDoc = XmlDocument.parse(sheetXml);

          extractedText.writeln('Worksheet: $sheetName');
          extractedText.writeln('=' * (sheetName.length + 12));

          // Extract all cell data
          final cells = sheetDoc.findAllElements('c');
          final rowData = <int, List<String>>{};

          for (final cell in cells) {
            final cellRef = cell.getAttribute('r');
            if (cellRef == null) continue;

            final rowNum = _extractRowNumber(cellRef);
            final cellValue = _extractCellValue(cell, sharedStrings);

            if (cellValue.isNotEmpty) {
              rowData.putIfAbsent(rowNum, () => <String>[]);
              rowData[rowNum]!.add(cellValue);
            }
          }

          // Output rows in order
          final sortedRows = rowData.keys.toList()..sort();
          for (final rowNum in sortedRows) {
            final values = rowData[rowNum]!;
            if (values.isNotEmpty) {
              extractedText.writeln('Row $rowNum: ${values.join(' | ')}');
            }
          }

          extractedText.writeln();
        } catch (e) {
          print('Error processing sheet $sheetName: $e');
          extractedText.writeln('Error processing sheet $sheetName');
          extractedText.writeln();
        }
      }

      final result = extractedText.toString().trim();
      if (result.isEmpty) {
        return 'Excel file appears to be empty or contains no extractable text.';
      }

      return _cleanExtractedText(result);
    } catch (e) {
      print('Error extracting Excel text: $e');
      return 'Error extracting text from Excel file. Please ensure the file is not corrupted. Error: ${e.toString()}';
    }
  }

  /// Extract cell value from Excel cell element
  String _extractCellValue(XmlElement cell, List<String> sharedStrings) {
    final cellType = cell.getAttribute('t');
    final valueElement = cell.findElements('v').firstOrNull;

    if (valueElement == null) return '';

    final value = valueElement.value;

    if (value == null) return '';
    // Handle different cell types
    if (cellType == 's') {
      // Shared string
      final index = int.tryParse(value);
      if (index != null && index < sharedStrings.length) {
        return sharedStrings[index];
      }
    } else if (cellType == 'inlineStr') {
      // Inline string
      final inlineStr = cell.findElements('is').firstOrNull;
      if (inlineStr != null) {
        final tElement = inlineStr.findElements('t').firstOrNull;
        if (tElement != null) {
          return tElement.value!;
        }
      }
    } else {
      // Number, date, or other value
      return value;
    }

    return value;
  }

  /// Extract row number from cell reference (e.g., 'A1' -> 1)
  int _extractRowNumber(String cellRef) {
    final match = RegExp(r'(\d+)').firstMatch(cellRef);
    if (match != null) {
      return int.tryParse(match.group(1)!) ?? 1;
    }
    return 1;
  }

  /// Extract slide number from slide file name
  int _extractSlideNumber(String fileName) {
    final match = RegExp(r'slide(\d+)\.xml').firstMatch(fileName);
    if (match != null) {
      return int.tryParse(match.group(1)!) ?? 1;
    }
    return 1;
  }

  /// Send processing notification to user
  Future<void> _sendProcessingNotification(
      Session session, int userId, int materialId, String status) async {
    try {
      final material = await StudyMaterial.db.findById(session, materialId);
      if (material == null) {
        session.log(
            'Cannot send notification for non-existent material ID: $materialId',
            level: LogLevel.warning);
        return;
      }

      String message;
      String type;

      // a descriptive message and type based on the status
      switch (status) {
        case 'completed':
          message =
              'Your material "${material.title}" has been successfully processed and is ready to use.';
          type = 'document_ready';
          break;
        case 'failed':
          message =
              'We\'re sorry, but processing failed for your material "${material.title}". Please try uploading it again.';
          type = 'document_failed';
          break;
        default:
          // Don't send notifications for unknown statuses
          return;
      }

      //the notification record
      final notification = Notification(
        userId: userId,
        message: message,
        type: type,
        isRead: false,
        relatedId: materialId, // Link the notification to the material
        createdAt: DateTime.now(),
      );

      // Insert the notification into the database
      await Notification.db.insertRow(session, notification);

      session.log(
        'Notification created for user $userId: Material $materialId processing $status',
        level: LogLevel.info,
      );
    } catch (e) {
      session.log(
        'Failed to send processing notification for material $materialId: $e',
        level: LogLevel.error,
      );
    }
  }

  /// Helper methods for AI content parsing and generation

  String _getContentType(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return 'application/pdf';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'doc':
        return 'application/msword';
      case 'pptx':
        return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
      case 'ppt':
        return 'application/vnd.ms-powerpoint';
      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case 'txt':
        return 'text/plain';
      case 'md':
        return 'text/markdown';
      default:
        return 'application/octet-stream';
    }
  }

  List<String> _extractKeyPhrases(String text) {
    final words = text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .split(RegExp(r'\s+'))
        .where((word) => word.length > 3)
        .toList();

    final wordCount = <String, int>{};
    for (final word in words) {
      wordCount[word] = (wordCount[word] ?? 0) + 1;
    }

    final sortedWords = wordCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedWords.take(10).map((e) => e.key).toList();
  }

  /// Update study history for user
  Future<void> _updateStudyHistory(
    Session session,
    int userId, {
    List<int>? materialIds,
  }) async {
    var history = await StudyHistory.db
        .findFirstRow(session, where: (t) => t.userId.equals(userId));

    if (history == null) {
      history = StudyHistory(
        userId: userId,
        materialIds: materialIds ?? [],
        questionIds: [],
        summaryIds: [],
        writingIds: [],
        progress: 0.0,
        lastUpdated: DateTime.now(),
      );
      await StudyHistory.db.insertRow(session, history);
    } else {
      history = history.copyWith(
        materialIds: materialIds != null
            ? {...history.materialIds, ...materialIds}.toList()
            : history.materialIds,
        lastUpdated: DateTime.now(),
      );
      await StudyHistory.db.updateRow(session, history);
    }
  }

  /// Clean and format extracted text
  String _cleanExtractedText(String rawText) {
    return rawText
        // Remove excessive whitespace
        .replaceAll(RegExp(r'\s+'), ' ')
        // Remove control characters
        .replaceAll(RegExp(r'[\x00-\x1F\x7F]'), '')
        // Normalize line breaks
        .replaceAll(RegExp(r'\r\n|\r|\n'), '\n')
        // Remove multiple consecutive line breaks
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        // Trim whitespace
        .trim();
  }
}

/// Helper class for file processing results
class FileProcessingResult {
  final String extractedText;
  final int wordCount;
  final List<String> keyPhrases;

  FileProcessingResult({
    required this.extractedText,
    required this.wordCount,
    required this.keyPhrases,
  });
}

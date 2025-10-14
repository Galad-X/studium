// lib/src/services/export_service.dart
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:docx_template/docx_template.dart';
import 'package:open_filex/open_filex.dart';

enum ExportFormat { pdf, docx }

class ExportService {
  /// Generates a document from the given content and saves it to the device.
  /// Returns the path to the saved file.
  Future<String> exportDocument({
    required String title,
    required String content,
    required ExportFormat format,
  }) async {
    final fileName = '${title.replaceAll(' ', '_')}.${format.name}';
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$fileName';

    late Uint8List fileBytes;

    if (format == ExportFormat.pdf) {
      fileBytes = await _createPdf(title, content);
    } else {
      fileBytes = await _createDocx(title, content);
    }

    final file = File(path);
    await file.writeAsBytes(fileBytes);

    return path;
  }

  /// Opens the generated file using the device's default application.
  Future<void> openFile(String path) async {
    final result = await OpenFilex.open(path);
    if (result.type != ResultType.done) {
      throw Exception('Could not open file: ${result.message}');
    }
  }

  /// Generates a PDF document.
  Future<Uint8List> _createPdf(String title, String content) async {
    final pdf = pw.Document();

    // Load a font that supports a wide range of characters
    final fontData = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(title,
                  style: pw.TextStyle(
                      font: ttf, fontSize: 24, fontWeight: pw.FontWeight.bold)),
            ),
            pw.Paragraph(
              text: content,
              style: pw.TextStyle(font: ttf, fontSize: 12, height: 1.5),
            ),
          ];
        },
      ),
    );
    return pdf.save();
  }

  /// Generates a DOCX document using a template.
  Future<Uint8List> _createDocx(String title, String content) async {
    // Load the template from assets
    final templateBytes =
        await rootBundle.load('assets/templates/export_template.docx');
    final docx =
        await DocxTemplate.fromBytes(templateBytes.buffer.asUint8List());

    // Replace placeholders in the template with actual content
    final contentObject = Content();
    contentObject.add(TextContent("title", title));
    contentObject.add(TextContent("content", content));

    final generatedBytes = await docx.generate(contentObject);
    if (generatedBytes == null) {
      throw Exception('Failed to generate DOCX file.');
    }

    // Convert List<int> to Uint8List
    return Uint8List.fromList(generatedBytes);
  }
}

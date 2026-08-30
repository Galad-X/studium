import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:xml/xml.dart';

class RoomResourceTextExtractor {
  static const maxCharacters = 100000;

  static String? extract(String extension, Uint8List bytes) {
    final normalized = extension.trim().toLowerCase().replaceFirst('.', '');
    try {
      final text = switch (normalized) {
        'txt' || 'md' => utf8.decode(bytes),
        'docx' => _extractXmlFiles(bytes, const ['word/document.xml']),
        'pptx' => _extractArchivePrefix(bytes, 'ppt/slides/slide'),
        'xlsx' => _extractSpreadsheet(bytes),
        'pdf' => _extractPdfOperators(bytes),
        _ => null,
      };
      if (text == null) return null;
      final normalizedText = text.trim().replaceAll(RegExp(r'\s+'), ' ');
      if (normalizedText.isEmpty) return null;
      return normalizedText.length > maxCharacters
          ? normalizedText.substring(0, maxCharacters)
          : normalizedText;
    } on FormatException {
      return null;
    } catch (_) {
      return null;
    }
  }

  static String _extractXmlFiles(Uint8List bytes, List<String> names) {
    final archive = ZipDecoder().decodeBytes(bytes);
    final buffer = StringBuffer();
    for (final name in names) {
      final file = archive.findFile(name);
      if (file == null) continue;
      final document =
          XmlDocument.parse(utf8.decode(file.content as List<int>));
      for (final node in document.descendants.whereType<XmlText>()) {
        buffer.write(' ');
        buffer.write(node.value);
      }
    }
    return buffer.toString();
  }

  static String _extractArchivePrefix(Uint8List bytes, String prefix) {
    final archive = ZipDecoder().decodeBytes(bytes);
    final names = archive.files
        .where((file) => !file.isFile ? false : file.name.startsWith(prefix))
        .map((file) => file.name)
        .toList()
      ..sort();
    return _extractXmlFiles(bytes, names);
  }

  static String _extractSpreadsheet(Uint8List bytes) {
    final archive = ZipDecoder().decodeBytes(bytes);
    final buffer = StringBuffer();
    for (final file in archive.files.where(
      (file) =>
          file.isFile &&
          (file.name == 'xl/sharedStrings.xml' ||
              file.name.startsWith('xl/worksheets/sheet')),
    )) {
      final document =
          XmlDocument.parse(utf8.decode(file.content as List<int>));
      for (final node in document.descendants.whereType<XmlText>()) {
        buffer.write(' ');
        buffer.write(node.value);
      }
    }
    return buffer.toString();
  }

  static String _extractPdfOperators(Uint8List bytes) {
    final source = latin1.decode(bytes, allowInvalid: true);
    final buffer = StringBuffer();
    for (final match in RegExp(r'\(([^()]*)\)\s*Tj').allMatches(source)) {
      buffer.write(' ');
      buffer.write(match.group(1));
    }
    return buffer.toString();
  }
}

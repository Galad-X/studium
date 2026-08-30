// lib/src/services/aws_s3_service.dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';
import 'package:http/http.dart' as http;

/// A service for interacting with an AWS S3 bucket.
///
/// Handles request signing (AWS Signature V4) for secure communication.
class AwsS3Service {
  final String _accessKey;
  final String _secretKey;
  final String _region;
  final String _bucketName;
  final String _host;
  final String _service = 's3';

  AwsS3Service.fromConfig(Serverpod serverpod)
      : _accessKey = _getConfigValue(serverpod, 'aws_access_key_id'),
        _secretKey = _getConfigValue(serverpod, 'aws_secret_access_key'),
        _region = _getConfigValue(serverpod, 'aws_region'),
        _bucketName = _getConfigValue(serverpod, 'aws_s3_bucket'),
        _host = 's3.${_getConfigValue(serverpod, 'aws_region')}.amazonaws.com';

  /// Helper method to get configuration values
  static String _getConfigValue(Serverpod serverpod, String key) {
    final value = serverpod.getPassword(key);
    if (value != null &&
        value.trim().isNotEmpty &&
        value != 'replace-me' &&
        !value.startsWith('your_')) {
      return value;
    }

    throw Exception('Configuration value for "$key" not found. '
        'Please add it to passwords.yaml file or update the configuration access method.');
  }

  /// Alternative constructor with explicit parameters
  AwsS3Service({
    required String accessKey,
    required String secretKey,
    required String region,
    required String bucketName,
  })  : _accessKey = accessKey,
        _secretKey = secretKey,
        _region = region,
        _bucketName = bucketName,
        _host = 's3.$region.amazonaws.com';

  /// Uploads a file to the S3 bucket and returns its public URL.
  Future<String> uploadFile(
      String filePath, Uint8List bytes, String contentType) async {
    final uri = Uri.https(_host, '/$_bucketName/$filePath');
    final now = DateTime.now().toUtc();

    final headers = {
      'host': uri.host,
      'x-amz-date': _formatDate(now),
      'x-amz-content-sha256': sha256.convert(bytes).toString(),
      'content-type': contentType,
      'content-length': bytes.length.toString(),
    };

    final authorizationHeader = _getAuthorizationHeader(
      method: 'PUT',
      uri: uri,
      headers: headers,
      payload: bytes,
      timestamp: now,
    );
    headers['authorization'] = authorizationHeader;

    final response = await http.put(uri, headers: headers, body: bytes);

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to upload file to S3. Status: ${response.statusCode}, Body: ${response.body}');
    }

    // The public URL of the object
    return 'https://${uri.host}/${uri.pathSegments.join('/')}';
  }

  /// Deletes a file from the S3 bucket.
  Future<void> deleteFile(String filePath, {Session? session}) async {
    final uri = Uri.https(_host, '/$_bucketName/$filePath');
    final now = DateTime.now().toUtc();

    final headers = {
      'host': uri.host,
      'x-amz-date': _formatDate(now),
    };

    final authorizationHeader = _getAuthorizationHeader(
      method: 'DELETE',
      uri: uri,
      headers: headers,
      timestamp: now,
    );
    headers['authorization'] = authorizationHeader;

    final response = await http.delete(uri, headers: headers);

    if (response.statusCode != 204) {
      // Log as a warning instead of throwing an exception, as a failed delete
      // is often less critical than a failed upload.
      session?.log(
        'Warning: Failed to delete file from S3. Status: ${response.statusCode}, '
        'Body: ${response.body}',
        level: LogLevel.warning,
      );
    }
  }

  /// Generates the AWS Signature V4 authorization header.
  String _getAuthorizationHeader({
    required String method,
    required Uri uri,
    required Map<String, String> headers,
    Uint8List? payload,
    required DateTime timestamp,
  }) {
    final dateStamp = _formatDateStamp(timestamp);
    final amzDate = _formatDate(timestamp);
    final credentialScope = '$dateStamp/$_region/$_service/aws4_request';

    // Sort headers for canonical request
    final sortedHeaders = Map.fromEntries(
        headers.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
    final canonicalHeaders =
        sortedHeaders.entries.map((e) => '${e.key}:${e.value}\n').join();
    final signedHeaders = sortedHeaders.keys.join(';');

    // Hash the payload
    final payloadHash = sha256.convert(payload ?? []).toString();

    // Create canonical request
    final canonicalRequest =
        '$method\n${uri.path}\n\n$canonicalHeaders\n$signedHeaders\n$payloadHash';
    final canonicalRequestHash =
        sha256.convert(utf8.encode(canonicalRequest)).toString();

    // Create string to sign
    final stringToSign =
        'AWS4-HMAC-SHA256\n$amzDate\n$credentialScope\n$canonicalRequestHash';

    // Calculate signature
    final signingKey =
        _getSignatureKey(_secretKey, dateStamp, _region, _service);
    final signature =
        Hmac(sha256, signingKey).convert(utf8.encode(stringToSign)).toString();

    return 'AWS4-HMAC-SHA256 Credential=$_accessKey/$credentialScope, SignedHeaders=$signedHeaders, Signature=$signature';
  }

  /// Generates the signature key for AWS Signature V4.
  List<int> _getSignatureKey(
      String key, String dateStamp, String region, String service) {
    final kDate =
        Hmac(sha256, utf8.encode('AWS4$key')).convert(utf8.encode(dateStamp));
    final kRegion = Hmac(sha256, kDate.bytes).convert(utf8.encode(region));
    final kService = Hmac(sha256, kRegion.bytes).convert(utf8.encode(service));
    final kSigning =
        Hmac(sha256, kService.bytes).convert(utf8.encode('aws4_request'));
    return kSigning.bytes;
  }

  // AWS requires dates in `yyyyMMdd'T'HHmmss'Z'` format.
  String _formatDate(DateTime dt) {
    return '${dt.year}${_twoDigits(dt.month)}${_twoDigits(dt.day)}T${_twoDigits(dt.hour)}${_twoDigits(dt.minute)}${_twoDigits(dt.second)}Z';
  }

  // AWS requires date stamps in `yyyyMMdd` format for the credential scope.
  String _formatDateStamp(DateTime dt) {
    return '${dt.year}${_twoDigits(dt.month)}${_twoDigits(dt.day)}';
  }

  String _twoDigits(int n) => n >= 10 ? '$n' : '0$n';
}

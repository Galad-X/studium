import 'package:serverpod/serverpod.dart';
import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server.dart' as mailer;
import 'dart:io';
import 'configuration_secrets.dart';

// Custom email configuration class
class EmailConfig {
  final String smtpServer;
  final int smtpPort;
  final String smtpUser;
  final String fromEmail;
  final String fromName;

  EmailConfig({
    required this.smtpServer,
    required this.smtpPort,
    required this.smtpUser,
    required this.fromEmail,
    required this.fromName,
  });

  // Load configuration from environment variables
  static EmailConfig fromEnvironment() {
    return EmailConfig(
      smtpServer: Platform.environment['SMTP_SERVER'] ?? 'smtp.gmail.com',
      smtpPort: int.tryParse(Platform.environment['SMTP_PORT'] ?? '587') ?? 587,
      smtpUser: _requiredEnvironment('SMTP_USER'),
      fromEmail: _requiredEnvironment('FROM_EMAIL'),
      fromName: Platform.environment['FROM_NAME'] ?? 'Studium',
    );
  }

  static String _requiredEnvironment(String name) {
    final value = Platform.environment[name]?.trim();
    if (value == null || value.isEmpty) {
      throw Exception('Email configuration value "$name" is not configured.');
    }
    return value;
  }
}

class EmailSender {
  static Future<void> sendEmail({
    required Session session,
    required String to,
    required String subject,
    required String htmlBody,
    EmailConfig? emailConfig,
  }) async {
    // Use provided config or load from environment
    final config = emailConfig ?? EmailConfig.fromEnvironment();

    // Get password from Serverpod's password management
    final password = ConfigurationSecrets.read(session, 'smtpPassword') ??
        ConfigurationSecrets.read(session, 'ethereal_password');

    if (password == null ||
        password.trim().isEmpty ||
        password == 'replace-me') {
      throw Exception('SMTP password not configured in passwords.yaml');
    }

    final smtpServer = mailer.SmtpServer(
      config.smtpServer,
      port: config.smtpPort,
      username: config.smtpUser,
      password: password,
      allowInsecure: false,
      ssl: config.smtpPort == 465,
    );

    final message = mailer.Message()
      ..from = mailer.Address(config.fromEmail, config.fromName)
      ..recipients.add(to)
      ..subject = subject
      ..html = htmlBody;

    try {
      final sendReport = await mailer.send(message, smtpServer);
      session.log('Email sent: ${sendReport.toString()}', level: LogLevel.info);
    } catch (e) {
      session.log('Failed to send email: $e', level: LogLevel.error);
      throw Exception('Failed to send verification email.');
    }
  }
}

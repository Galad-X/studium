import 'package:serverpod/serverpod.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:io';

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
      smtpPort: int.parse(Platform.environment['SMTP_PORT'] ?? '587'),
      smtpUser: Platform.environment['SMTP_USER'] ?? '',
      fromEmail: Platform.environment['FROM_EMAIL'] ?? 'noreply@yourdomain.com',
      fromName: Platform.environment['FROM_NAME'] ?? 'Your App',
    );
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
    final password = session.serverpod.getPassword('smtpPassword');

    if (password == null) {
      throw Exception('SMTP password not configured in passwords.yaml');
    }

    final smtpServer = SmtpServer(
      config.smtpServer,
      port: config.smtpPort,
      username: config.smtpUser,
      password: password,
      allowInsecure: false,
      ssl: config.smtpPort == 465,
    );

    final message = Message()
      ..from = Address(config.fromEmail, config.fromName)
      ..recipients.add(to)
      ..subject = subject
      ..html = htmlBody;

    try {
      final sendReport = await send(message, smtpServer);
      session.log('Email sent: ${sendReport.toString()}', level: LogLevel.info);
    } catch (e) {
      session.log('Failed to send email: $e', level: LogLevel.error);
      throw Exception('Failed to send verification email.');
    }
  }
}

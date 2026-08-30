import 'dart:io';

import 'package:serverpod/serverpod.dart';

class ConfigurationSecrets {
  static const _environmentNames = {
    'openAi': 'STUDIUM_OPENAI_API_KEY',
    'openAI': 'STUDIUM_OPENAI_API_KEY',
    'ocrApiKey': 'STUDIUM_OCR_API_KEY',
    'stripe': 'STUDIUM_STRIPE_SECRET_KEY',
    'stripePriceId': 'STUDIUM_STRIPE_PRICE_ID',
    'stripeWebhookSecret': 'STUDIUM_STRIPE_WEBHOOK_SECRET',
    'paystack': 'STUDIUM_PAYSTACK_SECRET_KEY',
    'paystackPlanCode': 'STUDIUM_PAYSTACK_PLAN_CODE',
    'paystackWebhookSecret': 'STUDIUM_PAYSTACK_WEBHOOK_SECRET',
    'fcmServerKey': 'STUDIUM_FCM_SERVER_KEY',
    'smtpPassword': 'STUDIUM_SMTP_PASSWORD',
    'ethereal_password': 'STUDIUM_ETHEREAL_PASSWORD',
  };

  static String? read(Session session, String key) {
    final password = session.serverpod.getPassword(key)?.trim();
    if (password != null && password.isNotEmpty && password != 'replace-me') {
      return password;
    }
    final environmentName = _environmentNames[key];
    if (environmentName == null) return null;
    final environmentValue = Platform.environment[environmentName]?.trim();
    return environmentValue == null || environmentValue.isEmpty
        ? null
        : environmentValue;
  }
}

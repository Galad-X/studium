import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

import 'package:studium_server/src/web/routes/root.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';
import 'src/services/email_delivery_service.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    StaticRoute.directory(Directory('static')),
    '/**',
  );

  auth.AuthConfig.set(auth.AuthConfig(
    sendValidationEmail: (session, email, validationCode) async {
      final delivery = await EmailDeliveryService.enqueue(
        session,
        recipient: email,
        subject: 'Verify your Studium account',
        htmlBody:
            '<p>Your Studium verification code is <strong>$validationCode</strong>.</p>',
      );
      await EmailDeliveryService.deliver(session, delivery);
      return true;
    },
    sendPasswordResetEmail: (session, userInfo, validationCode) async {
      final email = userInfo.email;
      if (email == null || email.isEmpty) return false;
      final delivery = await EmailDeliveryService.enqueue(
        session,
        recipient: email,
        subject: 'Reset your Studium password',
        htmlBody:
            '<p>Your Studium password reset code is <strong>$validationCode</strong>.</p>',
      );
      await EmailDeliveryService.deliver(session, delivery);
      return true;
    },
  ));

  // Start the server.
  await pod.start();
}

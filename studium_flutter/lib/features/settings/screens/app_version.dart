// import 'package:flutter/material.dart';

// class AppVersion extends StatelessWidget {
//   const AppVersion({super.key});
//   Future<PackageInfo> _getAppVersion() async {
//     final packageInfo = await PackageInfo.fromPlatform();
//     return packageInfo;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _getAppVersion(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting ||
//             snapshot.hasError) {
//           return const SizedBox.shrink();
//         } else {
//           return Text(
//               "Version ${snapshot.data?.version} (${snapshot.data?.buildNumber})",
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   color:
//                       Theme.of(context).colorScheme.onSurface.withAlpha(152)));
//         }
//       },
//     );
//   }
// }

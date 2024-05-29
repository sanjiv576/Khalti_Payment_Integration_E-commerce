import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../config/router/app_route.dart';

class App extends StatelessWidget {
  App({super.key});

// read public key OR direct put public key here instead of reading from .env
  final String _publicKey = dotenv.get('PUBLIC_KEY');

  @override
  Widget build(BuildContext context) {
// Khalti payment integration // Step 4

    return KhaltiScope(
      publicKey: _publicKey,
      builder: (BuildContext context, GlobalKey<NavigatorState> navigatorKey) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ne', 'NE'),
          ],
          localizationsDelegates: const [KhaltiLocalizations.delegate],
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          routes: AppRoute.getAppRoutes(),
          initialRoute: AppRoute.homeRoute,
        );
      },
    );
  }
}

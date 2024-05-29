import 'package:flutter/material.dart';

import '../config/router/app_route.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      routes: AppRoute.getAppRoutes(),
      initialRoute: AppRoute.homeRoute,
    );
  }
}

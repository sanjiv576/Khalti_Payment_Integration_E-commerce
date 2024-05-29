import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'view/app.dart';

// void main() => runApp(const ProviderScope(child: App()));

// Khalti payment integration // Step 3
Future main() async {
  // reading .env file
  await dotenv.load(fileName: '.env');

  runApp(ProviderScope(child: App()));
}

import 'package:flutter/material.dart';
import 'package:rex_ai/screens/home_page.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'misc/pallete.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
  SpeechToText().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rex AI',
      theme: ThemeData.light(useMaterial3: true).copyWith
      (scaffoldBackgroundColor: Pallete.whiteColor),
      home: const HomePage(),
    );
  }
}


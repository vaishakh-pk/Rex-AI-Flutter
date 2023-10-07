import 'package:flutter/material.dart';
import 'package:rex_ai/screens/home_page.dart';
import 'package:rex_ai/services/openai_services.dart';

import 'misc/pallete.dart';

void main() {
  OpenAIService().testAPI();
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


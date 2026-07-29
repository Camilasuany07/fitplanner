import 'package:flutter/material.dart';
import 'features/home/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitPlanner',
      debugShowCheckedModeBanner: false, // 👈 remove faixa debug
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 27, 40, 160)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

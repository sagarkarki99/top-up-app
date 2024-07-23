import 'package:flutter/material.dart';
import 'package:top_up_app/features/beneficiary/presentation/beneficiary_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top-up App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const BeneficiaryView(),
    );
  }
}

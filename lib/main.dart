import 'package:flutter/material.dart';

void main() => runApp(BhedhukApp());

class BhedhukApp extends StatelessWidget {
  const BhedhukApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhedhuk App',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.yellow,
              secondary: Colors.white,
            ),
      ),
      
    );
  }
}




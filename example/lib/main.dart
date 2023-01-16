import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Moon Design for Flutter',
      color: Colors.white,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Moon Design for Flutter",
              style: TextStyle(fontSize: 72),
            ),
            SizedBox(height: 36),
            Text(
              "Coming soon...",
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF999CA0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

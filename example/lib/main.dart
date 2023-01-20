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
          children: [
            Text(
              "Moon Design for Flutter",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 800 ? 72 : 32,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width > 800 ? 36 : 16),
            Text(
              "Coming soon...",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 800 ? 24 : 20,
                color: const Color(0xFF999CA0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import '/welcome_screen.dart'; // Replace with actual screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashContent(),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2D2622),
            Color(0xFF3E2B1C),
            Color(0xFF4B2E18),
            Color(0xFF5A3B1D),
          ],
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/splash_logo.png',
          width: 220,
        ),
      ),
    );
  }
}

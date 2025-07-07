import 'package:flutter/material.dart';
import 'dart:ui'; // Required for ImageFilter
import 'User_Create_Authenticate/sign_in_screen.dart';
import 'User_Create_Authenticate/sign_up_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/welcome_bg.png',
            fit: BoxFit.cover,
          ),
          // Blur layer
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7), // Adjust blur strength here
            child: Container(
              color: Colors.black.withOpacity(0.001), // Optional dimming overlay
            ),
          ),

          // Overlay content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // Logo
                Image.asset(
                  'assets/splash_logo.png',
                  width: 180,
                ),
                const SizedBox(height: 20),

                // Heading
                Text(
                  "FOCUSED ON THE FUTURE",
                  style: TextStyle(
                    color: Colors.brown[900],
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                // Subheading
                Text(
                  "TRASFORMIAMO LE CRITICITÀ IN OPPORTUNITÀ",
                  style: TextStyle(
                    color: Colors.brown[900],
                    fontSize: 20,
                    letterSpacing: 1.1,
                  ),
                  textAlign: TextAlign.center,
                ),

                const Spacer(),

                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInPage()),
                      );
                      // Navigate to Sign In
                    },
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                      // Navigate to Sign Up
                    },
                    child:  Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.brown[900],
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

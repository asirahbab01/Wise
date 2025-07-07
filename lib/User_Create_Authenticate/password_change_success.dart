import 'package:flutter/material.dart';

class PasswordChangedSuccessPage extends StatefulWidget {
  const PasswordChangedSuccessPage({super.key});

  @override
  State<PasswordChangedSuccessPage> createState() =>
      _PasswordChangedSuccessPageState();
}

class _PasswordChangedSuccessPageState
    extends State<PasswordChangedSuccessPage> {
  @override
  void initState() {
    super.initState();

    // Redirect to sign-in after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/sign_in');
    });
  }

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF4B2E18);

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDEB),
      body: SafeArea(
        child: Stack(
          children: [
            // Brown header
            Container(
              height: 260,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              color: brown,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    "Reset\nPassword",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // White content card
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 180),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(32, 40, 32, 40),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Password Changed!",
                          style: TextStyle(
                            color: brown,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 24),
                        Icon(
                          Icons.check_circle_sharp,
                          color: Colors.green,
                          size: 80,
                        ),
                        SizedBox(height: 24),
                        Text(
                          "Your password has been \n changed successfully.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

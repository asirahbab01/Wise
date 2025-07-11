import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'otp_verify.dart'; // Your OTP page

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  String _message = '';
  bool _isLoading = false;

  Future<void> _sendOtp() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    final email = _emailController.text.trim();
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      setState(() {
        _isLoading = false;
        _message = "Enter a valid email address!";
      });
      return;
    }

    // Generate OTP
    final otp =
        (100000 + (DateTime.now().millisecondsSinceEpoch % 900000)).toString();

    // Store OTP in Firestore
    await FirebaseFirestore.instance
        .collection('password_otps')
        .doc(email)
        .set({
      'otp': otp,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Send OTP to email using email_auth
    final emailAuth = EmailAuth(sessionName: "Password Reset");
    await emailAuth.sendOtp(
      recipientMail: email,
      otpLength: 6,
    );

    setState(() {
      _isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpVerificationPage(email: email),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF4B2E18);

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDEB), // light background
      body: SafeArea(
        child: Stack(
          children: [
            // Brown header without curve
            Container(
              height: 260,
              width: double.infinity,
              color: brown,
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    "Forgot\nPassword",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // White form card
            Align(
              alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 170), // overlaps brown
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            hintText: "john@email.com",
                            hintStyle: TextStyle(color: Colors.black38),
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: brown,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            onPressed: _isLoading ? null : _sendOtp,
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    "NEXT",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        if (_message.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text(
                              _message,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        const SizedBox(height: 20), // extra space at the bottom
                      ],
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

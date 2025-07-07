import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wise/activity_page.dart';
import 'package:wise/firebase_options.dart';
import 'package:wise/Settings_Options/help_support_page.dart';
import 'package:wise/Settings_Options/privacy_policy_page.dart';
import 'package:wise/Settings_Options/profile_page.dart';
import 'package:wise/settings_page.dart';
import 'package:wise/Settings_Options/terms_and_conditions.dart';
import 'User_Create_Authenticate/forgot_password_screen.dart';
import 'home_page.dart';
import 'User_Create_Authenticate/sign_in_screen.dart';
import 'User_Create_Authenticate/sign_up_screen.dart';
import 'splash_screen.dart'; // Import your splash screen

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase if needed
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Uncomment if using Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WISE Legal & Tax',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const SplashScreen(),
      routes: {
        '/sign_in': (context) => const SignInPage(), // <-- Register here
        '/sign_up': (context) => const SignUpPage(), // (Optional)
        '/forgot_password': (context) => const ForgotPasswordPage(), // Add your forgot password page
        '/home': (context) => const HomePage(),
        '/activity': (context) => const ActivityPage(),
        '/settings': (context) => const  SettingsPage(),// Use the same HomePage for activity
        '/profile': (context) => const ProfilePage(), // Replace with your profile page
        '/privacy_policy': (context) => const PrivacyPolicyPage(),
        '/terms_and_conditions': (context) => const TermsAndConditions(), // Reuse for terms
        '/help_support': (context) => const HelpSupportPage(), // Add your help/support page
        
      },
    );
  }
}

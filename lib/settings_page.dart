import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF4B2E18);

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDEB), // light grey background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black87),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home'); // Redirect to home page
          }
        ),
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0, left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "General Settings",
              style: TextStyle(
                color: brown,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: brown,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  _SettingsTile(
                    title: "User Profile",
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                  _SettingsTile(
                    title: "Help & Support",
                    onTap: () {
                      Navigator.pushNamed(context, '/help_support');
                    },
                  ),
                  _SettingsTile(
                    title: "Privacy Policy",
                    onTap: () {
                      Navigator.pushNamed(context, '/privacy_policy');
                    },
                  ),
                  _SettingsTile(
                    title: "Terms & Conditions",
                    onTap: () {
                      Navigator.pushNamed(context, '/terms_and_conditions');
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    trailing: const Icon(Icons.logout, color: Colors.pinkAccent),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/sign_in',
                          (route) => false,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: brown,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: 2, // Settings tab
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_outlined),
            label: "Activity",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/activity');
          }
        },
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      onTap: onTap,
    );
  }
}

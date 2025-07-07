import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF4B2E18);

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDEB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FutureBuilder(
          future: rootBundle.loadString('assets/terms_and_conditions.md'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            // Replace lines starting with '*' with bullets
            String content = snapshot.data!;
            content = content.replaceAllMapped(
              RegExp(r'^\s*\*\s', multiLine: true),
              (match) => '• ',
            );
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: brown,
                borderRadius: BorderRadius.circular(28),
              ),
              child: SingleChildScrollView(
                child: Text(
                  content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    height: 1.5,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: brown,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: 2, // or appropriate index
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
          // Handle navigation
        },
      ),
    );
  }
}
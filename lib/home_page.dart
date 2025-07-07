import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String userName = '';
  String userRole = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        userName = doc.data()?['fullName'] ?? '';
        userRole = doc.data()?['role'] ?? 'Product Designer'; // Default role if not set
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF4B2E18);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image with overlay
          SizedBox(
            height: 340,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/bg_office.png',
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(0.45),
                ),
              ],
            ),
          ),
          // Main content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 48),
                // Profile header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isLoading
                              ? const SizedBox(
                                  width: 120,
                                  height: 18,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.white24,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  userName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                          const SizedBox(height: 2),
                          Text(
                            userRole.isNotEmpty ? userRole : "User",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Time and date
                const Text(
                  "07:40",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Monday, 01 November",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                // Check In/Out buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _CheckButton(
                        label: "Check In",
                        icon: Icons.touch_app,
                        color: brown,
                        onTap: () {
                          showAttendanceSuccessDialog(context);
                        },
                      ),
                      _CheckButton(
                        label: "Check out",
                        icon: Icons.touch_app,
                        color: brown,
                        onTap: () {
                          showAttendanceSuccessDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Activity summary
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ActivityInfo(
                        icon: Icons.access_time,
                        label: "07:40",
                        subLabel: "Clock-In",
                      ),
                      _ActivityInfo(
                        icon: Icons.access_time_rounded,
                        label: "16:40",
                        subLabel: "Clock-Out",
                      ),
                      _ActivityInfo(
                        icon: Icons.timer,
                        label: "09h00m",
                        subLabel: "Working Hrs",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Your Activity section
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.brown.shade50,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Your Activity",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              // Navigate to the full activity page
                              Navigator.pushNamed(context, '/activity');
                            },
                            child: const Text(
                              "View all",
                              style: TextStyle(
                                color: brown,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const _ActivityCard(
                        type: "Clock-In",
                        time: "07:30",
                        date: "01 November 2023",
                        icon: Icons.login,
                        iconColor: Colors.orange,
                        status: "On-time",
                      ),
                      const SizedBox(height: 12),
                      const _ActivityCard(
                        type: "Clock-Out",
                        time: "16:30",
                        date: "01 November 2023",
                        icon: Icons.logout,
                        iconColor: Colors.redAccent,
                        status: "On-time",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: brown,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
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
          if (index == _selectedIndex) return;
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            // Already on Home, do nothing or refresh
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/activity');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/settings');
          }
        },
      ),
    );
  }
}

class _CheckButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CheckButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: SizedBox(
          width: 90,
          height: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 36),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subLabel;

  const _ActivityInfo({
    required this.icon,
    required this.label,
    required this.subLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          subLabel,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String type;
  final String time;
  final String date;
  final IconData icon;
  final Color iconColor;
  final String status;

  const _ActivityCard({
    required this.type,
    required this.time,
    required this.date,
    required this.icon,
    required this.iconColor,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.15),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black, // <-- Make type black
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black, // <-- Make time black
                ),
              ),
              if (status.isNotEmpty)
                Text(
                  status,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 13,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// Place this function in your home_page.dart or a suitable location
void showNoConnectionDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.1),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, anim1, anim2) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Center(
          child: Container(
            width: 260,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top circle
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4B2E18),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.brown.shade100,
                      width: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  "Warning",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "You are not connected to the office Wi-Fi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4B2E18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Add your connect/retry logic here
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Connect",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showAttendanceSuccessDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.1),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, anim1, anim2) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 280,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.verified, // Green check badge
                    color: Colors.green,
                    size: 64,
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Attendance Successful!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Great job! Your attendance has been successfully recorded. You're all set for today.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B2E18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop(); // Close the dialog
                        Navigator.pushReplacementNamed(
                            context, '/home'); // Redirect to home page
                      },
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

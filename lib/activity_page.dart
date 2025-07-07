import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  int _selectedIndex = 1; // Activity tab

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF4B2E18);

    // Example data, replace with your real data source
    final List<Map<String, String>> attendance = [
      {"date": "28", "day": "Thu", "status": "Absent", "in": "-", "out": "-", "hours": "-"},
      {"date": "27", "day": "Wed", "status": "Absent", "in": "-", "out": "-", "hours": "-"},
      {"date": "26", "day": "Tue", "status": "Present", "in": "10:15am", "out": "7:18am", "hours": "9:03"},
      {"date": "25", "day": "Mon", "status": "Present", "in": "10:15am", "out": "7:18am", "hours": "9:03"},
      {"date": "24", "day": "Sun", "status": "Present", "in": "10:15am", "out": "7:18am", "hours": "9:03"},
      {"date": "23", "day": "Sat", "status": "Present", "in": "10:15am", "out": "7:18am", "hours": "9:03"},
      {"date": "22", "day": "Fri", "status": "Absent", "in": "-", "out": "-", "hours": "-"},
      {"date": "21", "day": "Thu", "status": "Present", "in": "10:15am", "out": "7:18am", "hours": "9:03"},
      {"date": "20", "day": "Wed", "status": "Present", "in": "10:15am", "out": "7:18am", "hours": "9:03"},
      {"date": "19", "day": "Tue", "status": "Present", "in": "10:15am", "out": "7:18am", "hours": "9:03"},
      {"date": "18", "day": "Mon", "status": "Present", "in": "10:15am", "out": "7:18am", "hours": "9:03"},
      {"date": "17", "day": "Sun", "status": "Present", "in": "10:15am", "out": "7:18am", "hours": "9:03"},
      {"date": "16", "day": "Sat", "status": "Present", "in": "10:15am", "out": "7:18am", "hours": "9:03"},
      {"date": "15", "day": "Fri", "status": "Present", "in": "10:15am", "out": "7:18am", "hours": "9:03"},
      {"date": "14", "day": "Thu", "status": "Present", "in": "10:15am", "out": "7:18am", "hours": "9:03"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDEB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  "General 9:00AM to 7:00PM",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              "Today,",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "9 hours and 9 mins",
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 19,
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          Expanded(child: Text("Date", style: TextStyle(color: brown, fontWeight: FontWeight.bold))),
                          Expanded(child: Text("Day", style: TextStyle(color: brown, fontWeight: FontWeight.bold))),
                          Expanded(child: Text("Status", style: TextStyle(color: brown, fontWeight: FontWeight.bold))),
                          Expanded(child: Text("In", style: TextStyle(color: brown, fontWeight: FontWeight.bold))),
                          Expanded(child: Text("Out", style: TextStyle(color: brown, fontWeight: FontWeight.bold))),
                          Expanded(child: Text("Hours", style: TextStyle(color: brown, fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: ListView.builder(
                        itemCount: attendance.length,
                        itemBuilder: (context, index) {
                          final row = attendance[index];
                          final isAbsent = row["status"] == "Absent";
                          final isToday = index == 0;
                          return Container(
                            color: isToday
                                ? Colors.grey.shade300
                                : Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    row["date"] ?? "",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    row["day"] ?? "",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    row["status"] ?? "",
                                    style: TextStyle(
                                      color: isAbsent ? Colors.red : brown,
                                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    row["in"] ?? "",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    row["out"] ?? "",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    row["hours"] ?? "",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24, right: 24),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  ),
                  onPressed: () {
                    // Handle leave logic here
                  },
                  icon: const Icon(Icons.card_giftcard, color: Colors.white),
                  label: const Text(
                    "Leave",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
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
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            // Already on Activity
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/settings');
          }
        },
      ),
    );
  }
}
// Add this LeaveApplicationPage widget to your project:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class LeaveApplicationPage extends StatefulWidget {
  final String leaveType;
  const LeaveApplicationPage({super.key, required this.leaveType});

  @override
  State<LeaveApplicationPage> createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();
  final TextEditingController reasonController = TextEditingController();
  bool isSubmitting = false;
  String message = '';

  Future<void> _pickDate(BuildContext context, bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isFrom ? fromDate! : toDate!,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  Future<void> _applyLeave() async {
  final reason = reasonController.text.trim();

  if (reason.isEmpty) {
    setState(() {
      message = "Please provide a reason for leave.";
    });
    return;
  }

  setState(() {
    isSubmitting = true;
    message = '';
  });

  try {
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email ?? "Unknown";

    await FirebaseFirestore.instance.collection('leave_applications').add({
      'leaveType': widget.leaveType,
      'fromDate': fromDate?.toIso8601String(),
      'toDate': toDate?.toIso8601String(),
      'reason': reason,
      'email': userEmail, // Save the user's email here
      'timestamp': FieldValue.serverTimestamp(),
    });

    setState(() {
      message = 'Leave application submitted!';
      isSubmitting = false;
    });

    reasonController.clear();
  } catch (e) {
    setState(() {
      message = "Something went wrong. Please try again.";
      isSubmitting = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF4B2E18);
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDEB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Application",
          style: TextStyle(
            color: brown,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  "Request Status:",
                  style: TextStyle(
                    color: brown,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red.shade200, width: 1.5),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.transparent,
                  ),
                  child: Text(
                    widget.leaveType,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "From Date:",
              style: TextStyle(
                color: brown,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () => _pickDate(context, true),
              child: Container(
                width: double.infinity,
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: brown, width: 1.2),
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${fromDate!.day.toString().padLeft(2, '0')}/${fromDate!.month.toString().padLeft(2, '0')}/${fromDate!.year}",
                        style: const TextStyle(
                          color: brown,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Icon(Icons.calendar_today, color: brown),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "To Date:",
              style: TextStyle(
                color: brown,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () => _pickDate(context, false),
              child: Container(
                width: double.infinity,
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: brown, width: 1.2),
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${toDate!.day.toString().padLeft(2, '0')}/${toDate!.month.toString().padLeft(2, '0')}/${toDate!.year}",
                        style: const TextStyle(
                          color: brown,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Icon(Icons.calendar_today, color: brown),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: brown, width: 1.2),
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.transparent,
                ),
                child: TextField(
                  controller: reasonController,
                  maxLines: null,
                  expands: true,
                  style: const TextStyle(color: brown, fontSize: 20),
                  decoration: const InputDecoration(
                    hintText: "Reason",
                    hintStyle: TextStyle(color: Color(0xFFB6AFA7), fontSize: 20),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 120,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                  ),
                  onPressed: isSubmitting ? null : _applyLeave,
                  child: isSubmitting
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          "Apply",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                ),
              ),
            ),
            if (message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
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

import 'package:flutter/material.dart';

class LaborPage extends StatelessWidget {
  const LaborPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Labor Management")),
      body: const Center(
        child: Text("Labor Module (Attendance, Tasks, Payment)"),
      ),
    );
  }
}
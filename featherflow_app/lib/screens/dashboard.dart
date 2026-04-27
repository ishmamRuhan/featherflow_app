import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Widget card(BuildContext context, String title, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF01291E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(title, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Featherflow Dashboard")),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10),
        children: [
          card(context, "Labor", "/labor"),
          card(context, "Cost", "/cost"),
          card(context, "Feed", "/feed"),
          card(context, "Marketplace", "/marketplace"),
          card(context, "Disease", "/disease"),
          card(context, "Chatbot", "/chatbot"),
          card(context, "Vet Map", "/vet"),
          card(context, "Tax", "/tax"),
          card(context, "Blog", "/blog"),
          card(context, "Articles", "/articles"),
        ],
      ),
    );
  }
}
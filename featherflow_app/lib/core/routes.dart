import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/auth/login.dart';
import '../screens/auth/signup.dart';
import '../screens/user/dashboard.dart';
import '../screens/user/labor.dart' as labor_screen;
import '../screens/user/feed_management.dart';
import '../screens/user/cost_management.dart';
import '../screens/user/disease_detection.dart';

// TEMP PLACEHOLDERS (to stop crashes)
class _Placeholder extends StatelessWidget {
  final String title;
  const _Placeholder(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("$title Screen (Coming Soon)")),
    );
  }
}

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const userDashboard = '/user/dashboard';
  static const labor = '/user/labor';
  static const cost = '/user/cost';
  static const feed = '/user/feed';
  static const disease = '/user/disease';

  // TEMP missing modules (fix crash)
  static const marketplace = '/user/marketplace';
  static const blogging = '/user/blogging';
  static const vetMap = '/user/vet-map';
  static const tax = '/user/tax';
  static const environmental = '/user/environmental';

  // ADMIN placeholders
  static const adminDashboard = '/admin/dashboard';
  static const doctorDashboard = '/doctor/dashboard';
  static const deliveryDashboard = '/delivery/dashboard';
  static const pharmacyDashboard = '/pharmacy/dashboard';
  static const researcherDashboard = '/researcher/dashboard';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        login: (_) => const LoginScreen(),
        signup: (_) => const SignupScreen(),
        userDashboard: (_) => const UserDashboard(),
        labor: (_) => const labor_screen.LaborScreen(),
        cost: (_) => const CostManagementScreen(),
        feed: (_) => const FeedManagementScreen(),
        disease: (_) => const DiseaseDetectionScreen(),
        // placeholders
        marketplace: (_) => const _Placeholder("Marketplace"),
        blogging: (_) => const _Placeholder("Blogging"),
        vetMap: (_) => const _Placeholder("Vet Map"),
        tax: (_) => const _Placeholder("Tax Calculation"),
        environmental: (_) => const _Placeholder("Environment"),
        adminDashboard: (_) => const _Placeholder("Admin Dashboard"),
        doctorDashboard: (_) => const _Placeholder("Doctor Dashboard"),
        deliveryDashboard: (_) => const _Placeholder("Delivery Dashboard"),
        pharmacyDashboard: (_) => const _Placeholder("Pharmacy Dashboard"),
        researcherDashboard: (_) => const _Placeholder("Researcher Dashboard"),
      };
}
import '../screens/auth/login.dart';
import '../screens/auth/signup.dart';
import '../screens/dashboard.dart';
import '../screens/labor.dart';


class AppRoutes {
  static final routes = {
    '/': (context) => const LoginPage(),
    '/signup': (context) => const SignupPage(),
    '/dashboard': (context) => const DashboardPage(),
    '/labor': (context) => const LaborPage(),
   
  };
}
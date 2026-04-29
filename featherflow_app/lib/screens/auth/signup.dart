import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/routes.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  String _selectedRole = 'Farmer';

  final roles = ['Farmer', 'Doctor', 'Researcher'];

  final Map<String, String> _roleRoutes = {
    'Farmer': AppRoutes.userDashboard,
    'Doctor': AppRoutes.doctorDashboard,
    'Researcher': AppRoutes.researcherDashboard,
  };

  final Map<String, IconData> _roleIcons = {
    'Farmer': Icons.agriculture_rounded,
    'Doctor': Icons.medical_services_rounded,
    'Researcher': Icons.science_rounded,
  };

  final Map<String, String> _roleDesc = {
    'Farmer': 'Manage your poultry farm, track health & sales',
    'Doctor': 'Connect with farmers, provide vet consultations',
    'Researcher': 'Publish research, share disease discoveries',
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _signup() {
    final route = _roleRoutes[_selectedRole] ?? AppRoutes.userDashboard;
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height * 0.38,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF011810), AppTheme.primary, Color(0xFF024A37)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -60,
                  left: -60,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.03),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.31,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
            ),
          ),
          FadeTransition(
            opacity: _fadeIn,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.egg_alt_rounded,
                      size: 44,
                      color: AppTheme.accentLight,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Join Featherflow',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Create your free account today',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: size.height * 0.07),
                    // Form card
                    Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withOpacity(0.08),
                            blurRadius: 30,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create Account',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Choose your role to get started',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Role cards
                          ...roles.map((role) {
                            final selected = _selectedRole == role;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedRole = role),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? AppTheme.primary.withOpacity(0.06)
                                      : const Color(0xFFF8FAF9),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: selected
                                        ? AppTheme.primary
                                        : const Color(0xFFE0EDE8),
                                    width: selected ? 2 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        color: selected
                                            ? AppTheme.primary
                                            : const Color(0xFFE8F3EE),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        _roleIcons[role],
                                        size: 20,
                                        color: selected
                                            ? Colors.white
                                            : AppTheme.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            role,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: AppTheme.textPrimary,
                                            ),
                                          ),
                                          Text(
                                            _roleDesc[role]!,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 11,
                                              color: AppTheme.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (selected)
                                      const Icon(
                                        Icons.check_circle_rounded,
                                        color: AppTheme.primary,
                                        size: 20,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 16),
                          // Name row
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    hintText: 'John',
                                    labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    hintText: 'Doe',
                                    labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              hintText: 'you@farm.com',
                              prefixIcon: const Icon(Icons.email_outlined, size: 20),
                              labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
                            ),
                          ),
                          const SizedBox(height: 14),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              hintText: '+880 1700 000000',
                              prefixIcon: const Icon(Icons.phone_outlined, size: 20),
                              labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
                            ),
                          ),
                          const SizedBox(height: 14),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: '••••••••',
                              prefixIcon: const Icon(Icons.lock_outline, size: 20),
                              suffixIcon: const Icon(Icons.visibility_off_outlined, size: 20),
                              labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
                            ),
                          ),
                          const SizedBox(height: 14),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              hintText: '••••••••',
                              prefixIcon: const Icon(Icons.lock_outline, size: 20),
                              labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
                            ),
                          ),
                          const SizedBox(height: 22),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _signup,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primary,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Create Account as $_selectedRole',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.login,
                                ),
                                child: Text(
                                  'Sign In',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
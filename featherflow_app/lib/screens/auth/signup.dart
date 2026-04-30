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
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  // All 6 roles — same as login
  final List<String> roles = [
    'Farmer',
    'Admin',
    'Doctor',
    'Delivery',
    'Pharmacy',
    'Researcher',
  ];

  final Map<String, String> _roleRoutes = {
    'Farmer': AppRoutes.userDashboard,
    'Admin': AppRoutes.adminDashboard,
    'Doctor': AppRoutes.doctorDashboard,
    'Delivery': AppRoutes.deliveryDashboard,
    'Pharmacy': AppRoutes.pharmacyDashboard,
    'Researcher': AppRoutes.researcherDashboard,
  };

  final Map<String, IconData> _roleIcons = {
    'Farmer': Icons.agriculture_rounded,
    'Admin': Icons.admin_panel_settings_rounded,
    'Doctor': Icons.medical_services_rounded,
    'Delivery': Icons.delivery_dining_rounded,
    'Pharmacy': Icons.local_pharmacy_rounded,
    'Researcher': Icons.science_rounded,
  };

  final Map<String, String> _roleDesc = {
    'Farmer': 'Manage your poultry farm, track health & sales',
    'Admin': 'Oversee platform operations and all users',
    'Doctor': 'Connect with farmers, provide vet consultations',
    'Delivery': 'Handle feed, medicine & product deliveries',
    'Pharmacy': 'Manage medicines and supply to farmers',
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

  // ─── Helpers ───────────────────────────────────────────────────────────────

  Widget _gap() => const SizedBox(height: 14);

  Widget _sectionLabel(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 6),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppTheme.textSecondary,
            letterSpacing: 0.8,
          ),
        ),
      );

  Widget _field({
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    bool showToggle = false,
    VoidCallback? onToggle,
  }) =>
      TextField(
        obscureText: obscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, size: 20),
          suffixIcon: showToggle
              ? GestureDetector(
                  onTap: onToggle,
                  child: Icon(
                    obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                  ),
                )
              : null,
          labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
        ),
      );

  Widget _dropdown(
          {required String label,
          required IconData icon,
          required List<String> items}) =>
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 20),
          labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD4E4DF)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD4E4DF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.accent, width: 2),
          ),
        ),
        hint: Text('Select...', style: GoogleFonts.plusJakartaSans(fontSize: 13)),
        items: items
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e,
                      style: GoogleFonts.plusJakartaSans(fontSize: 13)),
                ))
            .toList(),
        onChanged: (_) {},
      );

  // ─── Role-specific fields ──────────────────────────────────────────────────

  Widget _farmerFields() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('FARM DETAILS'),
          _field(label: 'Farm Name', hint: 'Green Valley Poultry', icon: Icons.home_work_outlined),
          _gap(),
          _field(label: 'Farm Location / District', hint: 'e.g. Gazipur, Dhaka', icon: Icons.location_on_outlined),
          _gap(),
          _field(label: 'Total Bird Capacity', hint: 'e.g. 5000', icon: Icons.egg_outlined, keyboardType: TextInputType.number),
          _gap(),
          _dropdown(label: 'Farm Type', icon: Icons.category_outlined, items: ['Broiler', 'Layer', 'Breeder', 'Hatchery', 'Mixed']),
        ],
      );

  Widget _adminFields() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('ADMIN DETAILS'),
          _field(label: 'Organization / Company', hint: 'e.g. Featherflow HQ', icon: Icons.business_outlined),
          _gap(),
          _field(label: 'Admin Invite Code', hint: 'Enter your invite key', icon: Icons.vpn_key_outlined),
          _gap(),
          _dropdown(label: 'Admin Role Level', icon: Icons.shield_outlined, items: ['Super Admin', 'Operations Admin', 'Support Admin']),
        ],
      );

  Widget _doctorFields() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('PROFESSIONAL DETAILS'),
          _field(label: 'Veterinary License No.', hint: 'VET-2024-XXXXX', icon: Icons.badge_outlined),
          _gap(),
          _field(label: 'Specialization', hint: 'e.g. Poultry Health, Avian Medicine', icon: Icons.biotech_outlined),
          _gap(),
          _field(label: 'Hospital / Clinic Name', hint: 'e.g. Dhaka Vet Clinic', icon: Icons.local_hospital_outlined),
          _gap(),
          _field(label: 'Service Area / District', hint: 'e.g. Dhaka, Gazipur', icon: Icons.map_outlined),
          _gap(),
          _field(label: 'Years of Experience', hint: 'e.g. 5', icon: Icons.workspace_premium_outlined, keyboardType: TextInputType.number),
        ],
      );

  Widget _deliveryFields() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('DELIVERY DETAILS'),
          _field(label: 'National ID No.', hint: 'NID number', icon: Icons.badge_outlined),
          _gap(),
          _field(label: 'Vehicle Type', hint: 'e.g. Motorcycle, Van, Truck', icon: Icons.local_shipping_outlined),
          _gap(),
          _field(label: 'Vehicle Registration No.', hint: 'e.g. DHA-12-3456', icon: Icons.directions_car_outlined),
          _gap(),
          _field(label: 'Delivery Zone / Area', hint: 'e.g. Dhaka North, Gazipur', icon: Icons.location_on_outlined),
          _gap(),
          _dropdown(label: 'Employment Type', icon: Icons.work_outline_rounded, items: ['Full-time', 'Part-time', 'Freelance']),
        ],
      );

  Widget _pharmacyFields() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('PHARMACY DETAILS'),
          _field(label: 'Pharmacy / Shop Name', hint: 'e.g. AgriMed Pharmacy', icon: Icons.store_outlined),
          _gap(),
          _field(label: 'Drug License No.', hint: 'DL-XXXXX', icon: Icons.verified_outlined),
          _gap(),
          _field(label: 'Location / District', hint: 'e.g. Mymensingh', icon: Icons.location_on_outlined),
          _gap(),
          _dropdown(label: 'Pharmacy Type', icon: Icons.category_outlined, items: ['Veterinary', 'Agricultural', 'General + Vet']),
          _gap(),
          _field(label: 'Contact Person Name', hint: 'Manager or owner name', icon: Icons.person_outline_rounded),
        ],
      );

  Widget _researcherFields() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('RESEARCH PROFILE'),
          _field(label: 'Institution / University', hint: 'e.g. BAU, Mymensingh', icon: Icons.school_outlined),
          _gap(),
          _field(label: 'Research Field', hint: 'e.g. Avian Diseases, Genetics', icon: Icons.science_outlined),
          _gap(),
          _field(label: 'Academic Degree', hint: 'e.g. PhD, MSc in Poultry Science', icon: Icons.menu_book_outlined),
          _gap(),
          _field(label: 'ORCID / ResearchGate ID (optional)', hint: '0000-0000-0000-0000', icon: Icons.link_outlined),
        ],
      );

  Widget _buildRoleSpecificFields() {
    switch (_selectedRole) {
      case 'Farmer':     return _farmerFields();
      case 'Admin':      return _adminFields();
      case 'Doctor':     return _doctorFields();
      case 'Delivery':   return _deliveryFields();
      case 'Pharmacy':   return _pharmacyFields();
      case 'Researcher': return _researcherFields();
      default:           return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Top green gradient header
          Container(
            height: size.height * 0.38,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF011810), AppTheme.primary, Color(0xFF024A37)],
              ),
            ),
            child: Stack(children: [
              Positioned(
                top: -60, left: -60,
                child: Container(
                  width: 220, height: 220,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.03)),
                ),
              ),
              Positioned(
                bottom: 30, right: -20,
                child: Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.accent.withOpacity(0.08)),
                ),
              ),
            ]),
          ),
          // White surface underlay
          Positioned(
            top: size.height * 0.31, left: 0, right: 0, bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
            ),
          ),
          // Content
          FadeTransition(
            opacity: _fadeIn,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // Back button
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
                            child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Icon(Icons.egg_alt_rounded, size: 44, color: AppTheme.accentLight),
                    const SizedBox(height: 8),
                    Text('Join Featherflow',
                        style: GoogleFonts.playfairDisplay(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text('Create your free account today',
                        style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.white.withOpacity(0.6))),
                    SizedBox(height: size.height * 0.055),

                    // ── Form card with green glow border ──
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(color: AppTheme.accent.withOpacity(0.35), blurRadius: 0, spreadRadius: 2),
                          BoxShadow(color: AppTheme.accent.withOpacity(0.18), blurRadius: 20, spreadRadius: 4),
                          BoxShadow(color: AppTheme.primary.withOpacity(0.12), blurRadius: 30, offset: const Offset(0, 10)),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppTheme.accent.withOpacity(0.4), width: 1.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Create Account',
                                style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
                            const SizedBox(height: 4),
                            Text('Choose your role to get started',
                                style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppTheme.textSecondary)),
                            const SizedBox(height: 20),

                            // ── Role chips ──
                            Text('SIGN UP AS',
                                style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.textSecondary, letterSpacing: 0.8)),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: roles.map((role) {
                                final selected = _selectedRole == role;
                                return GestureDetector(
                                  onTap: () => setState(() => _selectedRole = role),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: selected ? AppTheme.primary : const Color(0xFFF0F6F3),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: selected ? AppTheme.primary : const Color(0xFFD4E4DF)),
                                      boxShadow: selected
                                          ? [BoxShadow(color: AppTheme.accent.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))]
                                          : null,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(_roleIcons[role], size: 14, color: selected ? Colors.white : AppTheme.textSecondary),
                                        const SizedBox(width: 6),
                                        Text(role,
                                            style: GoogleFonts.plusJakartaSans(
                                                fontSize: 12, fontWeight: FontWeight.w600, color: selected ? Colors.white : AppTheme.textSecondary)),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 12),

                            // Role description banner
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: Container(
                                key: ValueKey(_selectedRole),
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppTheme.accent.withOpacity(0.07),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppTheme.accent.withOpacity(0.2)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(_roleIcons[_selectedRole]!, size: 16, color: AppTheme.accent),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(_roleDesc[_selectedRole]!,
                                          style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppTheme.textSecondary)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // ── Personal Info ──
                            _sectionLabel('PERSONAL INFO'),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'First Name', hintText: 'John',
                                      labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Last Name', hintText: 'Doe',
                                      labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            _gap(),
                            _field(label: 'Email Address', hint: 'you@example.com', icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress),
                            _gap(),
                            _field(label: 'Phone Number', hint: '+880 1700 000000', icon: Icons.phone_outlined, keyboardType: TextInputType.phone),
                            _gap(),

                            // ── Role-specific fields ──
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
                              child: KeyedSubtree(key: ValueKey(_selectedRole), child: _buildRoleSpecificFields()),
                            ),
                            _gap(),

                            // ── Security ──
                            _sectionLabel('ACCOUNT SECURITY'),
                            _field(
                              label: 'Password', hint: '••••••••', icon: Icons.lock_outline,
                              obscure: _obscurePassword, showToggle: true,
                              onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                            _gap(),
                            _field(
                              label: 'Confirm Password', hint: '••••••••', icon: Icons.lock_outline,
                              obscure: _obscureConfirm, showToggle: true,
                              onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
                            ),
                            const SizedBox(height: 22),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _signup,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primary,
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: Text('Create Account as $_selectedRole',
                                    style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w600)),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already have an account? ',
                                    style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppTheme.textSecondary)),
                                GestureDetector(
                                  onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
                                  child: Text('Sign In',
                                      style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.primary)),
                                ),
                              ],
                            ),
                          ],
                        ),
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
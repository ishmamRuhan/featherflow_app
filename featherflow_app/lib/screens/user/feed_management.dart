import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/routes.dart';
import '../../widgets/common_widgets.dart';

class FeedManagementScreen extends StatefulWidget {
  const FeedManagementScreen({super.key});

  @override
  State<FeedManagementScreen> createState() => _FeedManagementScreenState();
}

class _FeedManagementScreenState extends State<FeedManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _feedStock = [
    {
      'name': 'Broiler Starter',
      'brand': 'ACI Feeds',
      'stock': 450,
      'unit': 'kg',
      'reorder': 100,
      'color': const Color(0xFF4CAF82),
      'icon': Icons.grass_rounded,
    },
    {
      'name': 'Broiler Grower',
      'brand': 'CP Feeds',
      'stock': 280,
      'unit': 'kg',
      'reorder': 150,
      'color': const Color(0xFF29B6F6),
      'icon': Icons.eco_rounded,
    },
    {
      'name': 'Layer Pellet',
      'brand': 'Nourish Feeds',
      'stock': 80,
      'unit': 'kg',
      'reorder': 200,
      'color': const Color(0xFFF4C552),
      'icon': Icons.grain_rounded,
    },
    {
      'name': 'Vitamin Premix',
      'brand': 'Renata',
      'stock': 12,
      'unit': 'kg',
      'reorder': 5,
      'color': const Color(0xFFE53935),
      'icon': Icons.science_rounded,
    },
  ];

  final List<Map<String, dynamic>> _schedules = [
    {
      'time': '6:00 AM',
      'type': 'Broiler Starter',
      'amount': '50 kg',
      'flock': 'Shed A (2000 birds)',
      'done': true,
    },
    {
      'time': '12:00 PM',
      'type': 'Broiler Grower',
      'amount': '60 kg',
      'flock': 'Shed B (3000 birds)',
      'done': false,
    },
    {
      'time': '6:00 PM',
      'type': 'Layer Pellet',
      'amount': '40 kg',
      'flock': 'Shed C (1500 birds)',
      'done': false,
    },
  ];

  final List<Map<String, dynamic>> _nutritionData = [
    {'label': 'Protein', 'value': 21.5, 'unit': '%', 'target': 22.0, 'color': const Color(0xFF4CAF82)},
    {'label': 'Energy', 'value': 3100, 'unit': 'kcal', 'target': 3200, 'color': const Color(0xFFF4C552)},
    {'label': 'Calcium', 'value': 0.9, 'unit': '%', 'target': 1.0, 'color': const Color(0xFF29B6F6)},
    {'label': 'Phosphorus', 'value': 0.45, 'unit': '%', 'target': 0.50, 'color': const Color(0xFFE53935)},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const UserDrawer(currentRoute: AppRoutes.feed),
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Feed Management',
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.accentLight,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          labelStyle: GoogleFonts.plusJakartaSans(
              fontSize: 12, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Stock'),
            Tab(text: 'Purchases'),
            Tab(text: 'Consumption'),
            Tab(text: 'Suppliers'),
            Tab(text: 'Reports'),
            Tab(text: 'Payments'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStockTab(),
          _buildPurchasesTab(),
          _buildConsumptionTab(),
          _buildSuppliersTab(),
          _buildReportsTab(),
          _buildPaymentsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddFeedSheet,
        backgroundColor: AppTheme.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add Record',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleTab() {
    // Daily consumption summary
    const totalConsumed = 185; // kg
    const totalBirds = 6500;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Daily summary
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.primary, Color(0xFF024A37)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statChip('Today\'s Total', '$totalConsumed kg', Icons.scale_rounded),
                _statChip('Birds', '$totalBirds', Icons.egg_outlined),
                _statChip('Per Bird', '${(totalConsumed * 1000 / totalBirds).toStringAsFixed(0)}g', Icons.restaurant_outlined),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'TODAY\'S FEEDING SCHEDULE',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          ..._schedules.asMap().entries.map((entry) {
            final i = entry.key;
            final s = entry.value;
            return _scheduleCard(s, i);
          }),
          const SizedBox(height: 20),
          Text(
            'WEEKLY CONSUMPTION',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8F0EC)),
            ),
            child: Column(
              children: [
                ...[
                  {'day': 'Mon', 'kg': 180.0},
                  {'day': 'Tue', 'kg': 192.0},
                  {'day': 'Wed', 'kg': 178.0},
                  {'day': 'Thu', 'kg': 200.0},
                  {'day': 'Fri', 'kg': 195.0},
                  {'day': 'Sat', 'kg': 185.0},
                  {'day': 'Today', 'kg': 130.0},
                ].map((d) {
                  final ratio = (d['kg'] as double) / 210;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 44,
                          child: Text(
                            d['day'] as String,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: ratio,
                              minHeight: 10,
                              backgroundColor: const Color(0xFFE8F0EC),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppTheme.accent),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${d['kg']}kg',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildStockTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Alerts
          ..._feedStock.where((f) => (f['stock'] as int) <= (f['reorder'] as int)).map((f) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.warning.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.warning.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: AppTheme.warning, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${f['name']} is low! Only ${f['stock']}${f['unit']} remaining.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.warning,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Text(
            'FEED INVENTORY',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          ..._feedStock.map((f) => _stockCard(f)),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildNutritionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.accent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.accent.withOpacity(0.25)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded,
                    color: AppTheme.accent, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Nutrition values are based on current feed mix for Broiler (Day 15)',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, color: AppTheme.textSecondary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'NUTRITIONAL ANALYSIS',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          ..._nutritionData.map((n) => _nutritionCard(n)),
          const SizedBox(height: 20),
          Text(
            'FEED FORMULA',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8F0EC)),
            ),
            child: Column(
              children: [
                _formulaRow('Maize', '55%', AppTheme.gold),
                _formulaRow('Soybean Meal', '30%', const Color(0xFF8D6E63)),
                _formulaRow('Rice Bran', '8%', const Color(0xFFBCAAA4)),
                _formulaRow('Vitamin Premix', '4%', AppTheme.accent),
                _formulaRow('Mineral Mix', '2%', AppTheme.info),
                _formulaRow('Salt', '1%', AppTheme.textMuted),
                const Divider(height: 20),
                _formulaRow('Total', '100%', AppTheme.primary),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildPurchasesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FEED PURCHASE RECORDS',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textSecondary,
                  letterSpacing: 0.8)),
          const SizedBox(height: 12),
          // Placeholder for purchase records
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8F0EC)),
            ),
            child: Center(
              child: Text('Purchase records will be displayed here',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14, color: AppTheme.textSecondary)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsumptionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FEED CONSUMPTION LOGS',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textSecondary,
                  letterSpacing: 0.8)),
          const SizedBox(height: 12),
          // Placeholder for consumption logs
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8F0EC)),
            ),
            child: Center(
              child: Text('Consumption logs and batch/flock usage will be displayed here',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14, color: AppTheme.textSecondary)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuppliersTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FEED SUPPLIERS',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textSecondary,
                  letterSpacing: 0.8)),
          const SizedBox(height: 12),
          // Placeholder for suppliers
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8F0EC)),
            ),
            child: Center(
              child: Text('Supplier management and low stock alerts will be displayed here',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14, color: AppTheme.textSecondary)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FEED REPORTS',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textSecondary,
                  letterSpacing: 0.8)),
          const SizedBox(height: 12),
          // Placeholder for reports
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8F0EC)),
            ),
            child: Center(
              child: Text('Monthly, yearly, and lifetime feed reports with export options will be displayed here',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14, color: AppTheme.textSecondary)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FEED PAYMENTS',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textSecondary,
                  letterSpacing: 0.8)),
          const SizedBox(height: 12),
          // Placeholder for payments
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8F0EC)),
            ),
            child: Center(
              child: Text('Feed payment section and cost tracking will be displayed here',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14, color: AppTheme.textSecondary)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statChip(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.accentLight, size: 22),
        const SizedBox(height: 4),
        Text(value,
            style: GoogleFonts.playfairDisplay(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        Text(label,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 10, color: Colors.white60)),
      ],
    );
  }

  Widget _scheduleCard(Map<String, dynamic> s, int i) {
    final done = s['done'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: done ? const Color(0xFFF0FAF5) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: done ? AppTheme.accent.withOpacity(0.4) : const Color(0xFFE8F0EC),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: done
                  ? AppTheme.accent.withOpacity(0.15)
                  : const Color(0xFFF0F6F3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              done ? Icons.check_circle_rounded : Icons.schedule_rounded,
              color: done ? AppTheme.accent : AppTheme.textSecondary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s['time'] as String,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary)),
                Text('${s['type']} • ${s['amount']}',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, color: AppTheme.textSecondary)),
                Text(s['flock'] as String,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 11, color: AppTheme.textMuted)),
              ],
            ),
          ),
          if (!done)
            GestureDetector(
              onTap: () => setState(() => _schedules[i]['done'] = true),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('Done',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            )
          else
            Text('Done',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.accent)),
        ],
      ),
    );
  }

  Widget _stockCard(Map<String, dynamic> f) {
    final stock = f['stock'] as int;
    final reorder = f['reorder'] as int;
    final isLow = stock <= reorder;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isLow
              ? AppTheme.warning.withOpacity(0.4)
              : const Color(0xFFE8F0EC),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (f['color'] as Color).withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(f['icon'] as IconData,
                size: 22, color: f['color'] as Color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(f['name'] as String,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary)),
                Text(f['brand'] as String,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 11, color: AppTheme.textSecondary)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$stock ${f['unit']}',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color:
                          isLow ? AppTheme.warning : AppTheme.textPrimary)),
              Text('Reorder: $reorder ${f['unit']}',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 10, color: AppTheme.textMuted)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _nutritionCard(Map<String, dynamic> n) {
    final ratio = (n['value'] as num) / (n['target'] as num);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8F0EC)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(n['label'] as String,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary)),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${n['value']}',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: n['color'] as Color),
                    ),
                    TextSpan(
                      text: ' / ${n['target']} ${n['unit']}',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12, color: AppTheme.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: ratio.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: const Color(0xFFE8F0EC),
              valueColor:
                  AlwaysStoppedAnimation<Color>(n['color'] as Color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formulaRow(String ingredient, String percent, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(ingredient,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w500)),
          ),
          Text(percent,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary)),
        ],
      ),
    );
  }

  void _showAddFeedSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          top: 24,
          left: 24,
          right: 24,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Add Feed Record',
                style: GoogleFonts.playfairDisplay(
                    fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Feed Type',
                hintText: 'e.g. Broiler Starter',
                prefixIcon: const Icon(Icons.grass_rounded, size: 20),
                labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity (kg)',
                hintText: '0',
                prefixIcon: const Icon(Icons.scale_rounded, size: 20),
                labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              decoration: InputDecoration(
                labelText: 'Flock / Shed',
                hintText: 'e.g. Shed A',
                prefixIcon: const Icon(Icons.home_work_outlined, size: 20),
                labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('Save Record',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
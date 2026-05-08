import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../core/routes.dart';
import '../../widgets/common_widgets.dart';

class LaborScreen extends StatefulWidget {
  const LaborScreen({super.key});
  @override
  State<LaborScreen> createState() => _LaborScreenState();
}

class _LaborScreenState extends State<LaborScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }
  @override
  void dispose() { _tabController.dispose(); super.dispose(); }

  final _workers = [
    {'name': 'Rahim Ahmed', 'role': 'Shed Manager', 'status': 'Present', 'pay': '৳12,000', 'days': 22, 'avatar': '👨‍🌾'},
    {'name': 'Karim Hassan', 'role': 'Feed Operator', 'status': 'Present', 'pay': '৳9,500', 'days': 20, 'avatar': '👷'},
    {'name': 'Sadia Begum', 'role': 'Egg Collector', 'status': 'Absent', 'pay': '৳8,000', 'days': 18, 'avatar': '👩‍🌾'},
    {'name': 'Noor Islam', 'role': 'Health Monitor', 'status': 'Present', 'pay': '৳10,500', 'days': 21, 'avatar': '🧑‍⚕️'},
    {'name': 'Jalal Uddin', 'role': 'Driver', 'status': 'On Leave', 'pay': '৳8,500', 'days': 17, 'avatar': '🚗'},
  ];

  @override
  Widget build(BuildContext context) {
    final presentCount = _workers.where((w) => w['status'] == 'Present').length;
    final absentCount = _workers.where((w) => w['status'] == 'Absent').length;
    final leaveCount = _workers.where((w) => w['status'] == 'On Leave').length;
    final totalPay = _workers.fold<double>(0, (sum, w) => sum + double.parse((w['pay'] as String).replaceAll('৳', '').replaceAll(',', '')));

    return Scaffold(
      backgroundColor: AppTheme.surface,
      drawer: const UserDrawer(currentRoute: AppRoutes.labor),
      appBar: AppBar(
        title: const Text('Labor Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          const PremiumBadge(),
          const SizedBox(width: 12),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: AppTheme.accentLight,
          labelStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 13),
          tabs: const [Tab(text: 'Workers'), Tab(text: 'Attendance'), Tab(text: 'Scheduling'), Tab(text: 'Performance'), Tab(text: 'Reports'), Tab(text: 'Analytics')],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primary,
        onPressed: () => _showAddWorkerDialog(context),
        icon: const Icon(Icons.person_add_rounded, color: Colors.white),
        label: Text('Add Worker', style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_WorkersTab(workers: _workers), _AttendanceTab(workers: _workers), _SchedulingTab(), _PerformanceTab(), _ReportsTab(), _AnalyticsTab()],
      ),
    );
  }

  void _showAddWorkerDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 24, right: 24, top: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add New Worker', style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: 'Full Name', prefixIcon: const Icon(Icons.person_outline, size: 20), labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13))),
            const SizedBox(height: 14),
            TextField(decoration: InputDecoration(labelText: 'Role / Position', prefixIcon: const Icon(Icons.work_outline, size: 20), labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13))),
            const SizedBox(height: 14),
            TextField(decoration: InputDecoration(labelText: 'Monthly Salary (৳)', prefixIcon: const Icon(Icons.attach_money_rounded, size: 20), labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13))),
            const SizedBox(height: 14),
            TextField(decoration: InputDecoration(labelText: 'Phone Number', prefixIcon: const Icon(Icons.phone_outlined, size: 20), labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13))),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Add Worker', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600))),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _WorkersTab extends StatelessWidget {
  final List<Map<String, dynamic>> workers;
  const _WorkersTab({required this.workers});

  @override
  Widget build(BuildContext context) {
    final totalWorkers = workers.length;
    final present = workers.where((w) => w['status'] == 'Present').length;
    final absent = workers.where((w) => w['status'] == 'Absent').length;
    final onLeave = workers.where((w) => w['status'] == 'On Leave').length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE8F0EC)),
            boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.05), blurRadius: 18, offset: const Offset(0, 8))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Labor Overview', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: _MiniStat('Workers', '$totalWorkers', AppTheme.primary)),
                const SizedBox(width: 10),
                Expanded(child: _MiniStat('Present', '$present', AppTheme.accent)),
                const SizedBox(width: 10),
                Expanded(child: _MiniStat('Absent', '$absent', AppTheme.danger)),
              ]),
              const SizedBox(height: 14),
              Row(children: [
                Expanded(child: _MiniStat('On Leave', '$onLeave', AppTheme.warning)),
                const SizedBox(width: 10),
                const Expanded(child: _MiniStat('Avg Attendance', '87%', AppTheme.info)),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text('Team Members', style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
        const SizedBox(height: 10),
        ...workers.map((w) => _WorkerCard(worker: w)),
      ],
    );
  }
}

class _WorkerCard extends StatelessWidget {
  final Map<String, dynamic> worker;
  const _WorkerCard({required this.worker});

  @override
  Widget build(BuildContext context) {
    final statusColors = {'Present': AppTheme.accent, 'Absent': AppTheme.danger, 'On Leave': AppTheme.warning};
    final color = statusColors[worker['status']] ?? AppTheme.textMuted;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE8F0EC))),
      child: Row(children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.08), shape: BoxShape.circle),
          child: Center(child: Text(worker['avatar'] as String, style: const TextStyle(fontSize: 24))),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(worker['name'] as String, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 15)),
          Text(worker['role'] as String, style: GoogleFonts.plusJakartaSans(color: AppTheme.textSecondary, fontSize: 12)),
          const SizedBox(height: 8),
          Row(children: [
            _MiniTag(label: '${worker['days']} days', color: AppTheme.surface),
            const SizedBox(width: 8),
            _MiniTag(label: worker['status'] as String, color: color),
          ]),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(worker['pay'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.primary)),
          const SizedBox(height: 8),
          StatusChip(label: worker['status'] as String, color: color),
        ]),
      ]),
    );
  }
}

class _AttendanceTab extends StatelessWidget {
  final List<Map<String, dynamic>> workers;
  const _AttendanceTab({required this.workers});

  @override
  Widget build(BuildContext context) {
    final total = workers.length;
    final present = workers.where((w) => w['status'] == 'Present').length;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE8F0EC))),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Attendance Summary', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
              const SizedBox(height: 10),
              Text('$present / $total present', style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text('Good attendance today', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppTheme.textSecondary)),
            ])),
            CircularProgressIndicator(value: total == 0 ? 0 : present / total, backgroundColor: const Color(0xFFE8F0EC), valueColor: const AlwaysStoppedAnimation(AppTheme.accent), strokeWidth: 6),
          ]),
        ),
        const SizedBox(height: 18),
        Text('Today’s Attendance', style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
        const SizedBox(height: 12),
        ...workers.map((w) {
          final isPresent = w['status'] == 'Present';
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE8F0EC))),
            child: Row(children: [
              Text(w['avatar'] as String, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(w['name'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700)),
                Text(w['role'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppTheme.textSecondary)),
              ])),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: isPresent ? AppTheme.accent.withOpacity(0.14) : AppTheme.danger.withOpacity(0.14), borderRadius: BorderRadius.circular(10)),
                child: Text(
                  w['status'] as String,
                  style: GoogleFonts.plusJakartaSans(fontSize: 12, color: isPresent ? AppTheme.accent : AppTheme.danger, fontWeight: FontWeight.w700),
                ),
              ),
            ]),
          );
        }),
      ],
    );
  }
}

class _PayrollTab extends StatelessWidget {
  final List<Map<String, dynamic>> workers;
  const _PayrollTab({required this.workers});

  @override
  Widget build(BuildContext context) {
    final totalPay = workers.fold<double>(0, (sum, w) => sum + double.parse((w['pay'] as String).replaceAll('৳', '').replaceAll(',', '')));
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE8F0EC))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Payroll Summary', style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
            const SizedBox(height: 10),
            Text('৳${totalPay.toStringAsFixed(0)}', style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.w700, color: AppTheme.primary)),
            const SizedBox(height: 6),
            Text('Total monthly payout for current active workers', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppTheme.textSecondary)),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical: 14)),
              child: Text('Run Payroll', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ]),
        ),
        const SizedBox(height: 18),
        Text('Upcoming Payments', style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
        const SizedBox(height: 12),
        ...workers.map((w) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE8F0EC))),
          child: Row(children: [
            Text(w['avatar'] as String, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(w['name'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700)),
              Text(w['role'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppTheme.textSecondary)),
            ])),
            Text(w['pay'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.primary)),
          ]),
        )),
      ],
    );
  }
}

class _SchedulingTab extends StatelessWidget {
  const _SchedulingTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE8F0EC)),
          ),
          child: Center(
            child: Text('Shift scheduling and assigned tasks will be displayed here',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, color: AppTheme.textSecondary)),
          ),
        ),
      ],
    );
  }
}

class _PerformanceTab extends StatelessWidget {
  const _PerformanceTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE8F0EC)),
          ),
          child: Center(
            child: Text('Worker performance tracking and farm section assignment will be displayed here',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, color: AppTheme.textSecondary)),
          ),
        ),
      ],
    );
  }
}

class _ReportsTab extends StatelessWidget {
  const _ReportsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE8F0EC)),
          ),
          child: Center(
            child: Text('Monthly and yearly labor reports with expense integration will be displayed here',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, color: AppTheme.textSecondary)),
          ),
        ),
      ],
    );
  }
}

class _AnalyticsTab extends StatelessWidget {
  const _AnalyticsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE8F0EC)),
          ),
          child: Center(
            child: Text('Workforce analytics and notifications will be displayed here',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, color: AppTheme.textSecondary)),
          ),
        ),
      ],
    );
  }
}

class _MiniTag extends StatelessWidget {
  final String label;
  final Color color;
  const _MiniTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _MiniStat(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.2))),
      child: Column(children: [
        Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w800, color: color)),
        Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppTheme.textSecondary)),
      ]),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
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
    _tabController = TabController(length: 3, vsync: this);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Labor Management'),
        actions: [const PremiumBadge(), const SizedBox(width: 12)],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: AppTheme.accentLight,
          labelStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 13),
          tabs: const [Tab(text: 'Workers'), Tab(text: 'Attendance'), Tab(text: 'Payroll')],
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
        children: [_WorkersTab(workers: _workers), _AttendanceTab(workers: _workers), _PayrollTab(workers: _workers)],
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
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Summary row
        Row(children: [
          Expanded(child: _MiniStat('Total', '${workers.length}', AppTheme.primary)),
          const SizedBox(width: 10),
          Expanded(child: _MiniStat('Present', '${workers.where((w) => w['status'] == 'Present').length}', AppTheme.accent)),
          const SizedBox(width: 10),
          Expanded(child: _MiniStat('Absent', '${workers.where((w) => w['status'] == 'Absent').length}', AppTheme.danger)),
        ]),
        const SizedBox(height: 16),
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE8F0EC))),
      child: Row(children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.08), shape: BoxShape.circle),
          child: Center(child: Text(worker['avatar'] as String, style: const TextStyle(fontSize: 22))),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(worker['name'] as String, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 14)),
          Text(worker['role'] as String, style: GoogleFonts.plusJakartaSans(color: AppTheme.textSecondary, fontSize: 12)),
          const SizedBox(height: 4),
          Row(children: [
            Icon(Icons.calendar_today_rounded, size: 12, color: AppTheme.textMuted),
            const SizedBox(width: 4),
            Text('${worker['days']} days this month', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppTheme.textMuted)),
          ]),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          StatusChip(label: worker['status'] as String, color: color),
          const SizedBox(height: 6),
          Text(worker['pay'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.primary)),
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
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Today — ${DateTime.now().toString().split(' ')[0]}', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
        const SizedBox(height: 12),
        ...workers.map((w) {
          final isPresent = w['status'] == 'Present';
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE8F0EC))),
            child: Row(children: [
              Text(w['avatar'] as String, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Expanded(child: Text(w['name'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600))),
              Switch(
                value: isPresent,
                activeColor: AppTheme.accent,
                onChanged: (_) {},
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
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [AppTheme.primary, Color(0xFF024A37)]),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: [
            Text('Total Payroll — May 2025', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.white60)),
            const SizedBox(height: 6),
            Text('৳48,500', style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: Text('Process Payroll', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
            ),
          ]),
        ),
        const SizedBox(height: 16),
        ...workers.map((w) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE8F0EC))),
          child: Row(children: [
            Text(w['avatar'] as String, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(w['name'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
              Text('${w['days']} days × daily rate', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppTheme.textSecondary)),
            ])),
            Text(w['pay'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.primary)),
          ]),
        )),
      ],
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
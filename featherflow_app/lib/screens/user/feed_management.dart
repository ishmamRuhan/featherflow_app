// Feed Management Screen
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';
import '../../widgets/common_widgets.dart';

class FeedManagementScreen extends StatefulWidget {
  const FeedManagementScreen({super.key});
  @override
  State<FeedManagementScreen> createState() => _FeedManagementScreenState();
}

class _FeedManagementScreenState extends State<FeedManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tab;
  @override
  void initState() { super.initState(); _tab = TabController(length: 3, vsync: this); }
  @override
  void dispose() { _tab.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed Management'),
        bottom: TabBar(
          controller: _tab,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: AppTheme.accentLight,
          labelStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, fontSize: 13),
          tabs: const [Tab(text: 'Schedule'), Tab(text: 'Stock'), Tab(text: 'Nutrition')],
        ),
      ),
      body: TabBarView(controller: _tab, children: [
        _FeedSchedule(),
        _FeedStock(),
        _FeedNutrition(),
      ]),
    );
  }
}

class _FeedSchedule extends StatelessWidget {
  final _schedule = [
    {'time': '6:00 AM', 'amount': '25 kg', 'type': 'Starter Feed', 'shed': 'Shed A', 'done': true},
    {'time': '12:00 PM', 'amount': '30 kg', 'type': 'Grower Feed', 'shed': 'Shed A & B', 'done': true},
    {'time': '6:00 PM', 'amount': '25 kg', 'type': 'Layer Feed', 'shed': 'All Sheds', 'done': false},
    {'time': '8:00 PM', 'amount': '10 kg', 'type': 'Supplement Mix', 'shed': 'Shed C', 'done': false},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppTheme.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.accent.withOpacity(0.3))),
        child: Row(children: [
          const Icon(Icons.info_outline_rounded, color: AppTheme.accent, size: 20),
          const SizedBox(width: 10),
          Text('2 of 4 feedings completed today', style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppTheme.accent, fontWeight: FontWeight.w600)),
        ]),
      ),
      const SizedBox(height: 16),
      ..._schedule.map((s) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: (s['done'] as bool) ? Colors.white : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: (s['done'] as bool) ? AppTheme.accent.withOpacity(0.3) : const Color(0xFFE8F0EC)),
        ),
        child: Row(children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: (s['done'] as bool) ? AppTheme.accent.withOpacity(0.1) : AppTheme.primary.withOpacity(0.06),
              shape: BoxShape.circle,
            ),
            child: Icon(
              (s['done'] as bool) ? Icons.check_circle_rounded : Icons.schedule_rounded,
              color: (s['done'] as bool) ? AppTheme.accent : AppTheme.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(s['time'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700)),
            Text('${s['amount']} — ${s['type']}', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppTheme.textSecondary)),
            Text(s['shed'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppTheme.textMuted)),
          ])),
          if (!(s['done'] as bool))
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text('Mark Done', style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w600)),
            ),
        ]),
      )),
    ]);
  }
}

class _FeedStock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stocks = [
      {'name': 'Layer Feed', 'stock': 320, 'max': 500, 'unit': 'kg', 'color': AppTheme.accent},
      {'name': 'Starter Feed', 'stock': 80, 'max': 300, 'unit': 'kg', 'color': AppTheme.info},
      {'name': 'Grower Feed', 'stock': 45, 'max': 400, 'unit': 'kg', 'color': AppTheme.warning},
      {'name': 'Vitamin Mix', 'stock': 12, 'max': 50, 'unit': 'kg', 'color': AppTheme.primary},
    ];
    return ListView(padding: const EdgeInsets.all(16), children: [
      ...stocks.map((s) {
        final pct = (s['stock'] as int) / (s['max'] as int);
        final isLow = pct < 0.2;
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isLow ? AppTheme.danger.withOpacity(0.3) : const Color(0xFFE8F0EC)),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(s['name'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700))),
              if (isLow) StatusChip(label: 'Low Stock!', color: AppTheme.danger),
            ]),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('${s['stock']} ${s['unit']} remaining', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppTheme.textSecondary)),
              Text('of ${s['max']} ${s['unit']}', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppTheme.textMuted)),
            ]),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: pct, backgroundColor: (s['color'] as Color).withOpacity(0.1), valueColor: AlwaysStoppedAnimation(isLow ? AppTheme.danger : s['color'] as Color), minHeight: 8, borderRadius: BorderRadius.circular(4)),
          ]),
        );
      }),
    ]);
  }
}

class _FeedNutrition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nutrients = [
      {'name': 'Protein', 'pct': '18%', 'value': 0.72, 'color': AppTheme.primary},
      {'name': 'Energy (kcal)', 'pct': '2800', 'value': 0.85, 'color': AppTheme.accent},
      {'name': 'Calcium', 'pct': '3.5%', 'value': 0.90, 'color': AppTheme.warning},
      {'name': 'Phosphorus', 'pct': '0.6%', 'value': 0.60, 'color': AppTheme.info},
      {'name': 'Fat', 'pct': '4%', 'value': 0.40, 'color': AppTheme.danger},
    ];
    return ListView(padding: const EdgeInsets.all(16), children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE8F0EC))),
        child: Column(children: [
          Text('Daily Nutrition Plan', style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.w700)),
          Text('Based on 1,240 layer chickens', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppTheme.textSecondary)),
          const SizedBox(height: 16),
          ...nutrients.map((n) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(n['name'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                Text(n['pct'] as String, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700, color: n['color'] as Color)),
              ]),
              const SizedBox(height: 6),
              LinearProgressIndicator(value: n['value'] as double, backgroundColor: (n['color'] as Color).withOpacity(0.1), valueColor: AlwaysStoppedAnimation(n['color'] as Color), minHeight: 6, borderRadius: BorderRadius.circular(4)),
            ]),
          )),
        ]),
      ),
    ]);
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gutsyx/core/theme.dart';
import 'package:gutsyx/features/history/providers/stool_provider.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stoolEntries = ref.watch(stoolProvider);
    final weeklyScore = ref.read(stoolProvider.notifier).calculateWeeklyScore();

    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('GutsyX AI', 
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              background: Container(color: AppTheme.backgroundWhite),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildScoreGauge(weeklyScore),
                  const SizedBox(height: 24),
                  _buildActionButtons(context),
                  const SizedBox(height: 24),
                  const Text('Weekly Trend', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildTrendChart(stoolEntries),
                  const SizedBox(height: 24),
                  const Text('Recent Scans', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildRecentList(stoolEntries),
                  const SizedBox(height: 100), // Space for FAB
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/scan'),
        label: const Text('New Scan', 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.camera_alt, color: Colors.white),
        backgroundColor: AppTheme.metallicPurple,
      ),
    );
  }

  Widget _buildScoreGauge(double score) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text('Gut Health Score', 
            style: TextStyle(color: Colors.grey, fontSize: 16)),
          const SizedBox(height: 16),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 140,
                width: 140,
                child: CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 12,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.electricBlue),
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${score.toInt()}', 
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                  Text(score >= 80 ? 'Excellent' : 'Good', 
                    style: TextStyle(
                      color: score >= 80 ? Colors.green : Colors.orange, 
                      fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            score >= 80 
              ? 'Your gut health is optimal! Keep it up.' 
              : 'Try increasing your fiber intake this week.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _actionCard(
            context,
            'AI Analysis',
            Icons.auto_awesome,
            AppTheme.metallicPurple,
            () => context.push('/scan'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _actionCard(
            context,
            'Full Report',
            Icons.bar_chart,
            AppTheme.electricBlue,
            () {},
          ),
        ),
      ],
    );
  }

  Widget _actionCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendChart(List stoolEntries) {
    return Container(
      height: 220,
      padding: const EdgeInsets.fromLTRB(10, 24, 24, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 3),
                const FlSpot(1, 4),
                const FlSpot(2, 3.5),
                const FlSpot(3, 5),
                const FlSpot(4, 4),
                const FlSpot(5, 4.5),
                const FlSpot(6, 4),
              ],
              isCurved: true,
              color: AppTheme.electricBlue,
              barWidth: 4,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: AppTheme.electricBlue.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentList(List stoolEntries) {
    if (stoolEntries.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Text('No scans yet. Start your journey!', 
            style: TextStyle(color: Colors.grey)),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stoolEntries.length > 3 ? 3 : stoolEntries.length,
      itemBuilder: (context, index) {
        final entry = stoolEntries[index];
        return Card(
          color: Colors.white,
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.electricBlue.withOpacity(0.1),
              child: const Icon(Icons.water_drop, color: AppTheme.electricBlue),
            ),
            title: Text('Bristol Scale ${entry.bristolScale}'),
            subtitle: Text('${entry.timestamp.day} ${_getMonth(entry.timestamp.month)}'),
            trailing: const Icon(Icons.chevron_right),
          ),
        );
      },
    );
  }

  String _getMonth(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}

import 'package:flutter/material.dart';
import '../services/dashboard_service.dart';
import 'summary_card.dart';

class DashboardSummaryWidget extends StatelessWidget {
  final String companyId;
  final String siteId;

  const DashboardSummaryWidget({
    super.key,
    required this.companyId,
    required this.siteId,
  });

  @override
  Widget build(BuildContext context) {
    final service = DashboardService();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Dashboard Summary",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            Expanded(
              child: StreamBuilder<int>(
                stream: service.getWorkersCount(companyId, siteId),
                builder: (context, snapshot) {
                  return SummaryCard(
                    title: "Workforce",
                    value: "${snapshot.data ?? 0}",
                    icon: Icons.people,
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: StreamBuilder<int>(
                stream: service.getMaterialsCount(companyId, siteId),
                builder: (context, snapshot) {
                  return SummaryCard(
                    title: "Materials",
                    value: "${snapshot.data ?? 0}",
                    icon: Icons.inventory,
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: StreamBuilder<double>(
                stream: service.getTotalExpenses(companyId, siteId),
                builder: (context, snapshot) {
                  return SummaryCard(
                    title: "Expenses",
                    value: "₹${(snapshot.data ?? 0).toStringAsFixed(0)}",
                    icon: Icons.attach_money,
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: StreamBuilder<double>(
                stream: service.getProgress(companyId, siteId),
                builder: (context, snapshot) {
                  return SummaryCard(
                    title: "Progress",
                    value: "${(snapshot.data ?? 0).toStringAsFixed(0)}%",
                    icon: Icons.trending_up,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

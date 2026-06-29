import 'package:flutter/material.dart';

import '../models/dashboard_card_model.dart';
import 'summary_card.dart';

class DashboardSummaryWidget extends StatelessWidget {
  final List<DashboardCardModel> cards;
  final Map<String, String> values;

  const DashboardSummaryWidget({
    super.key,
    required this.cards,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Today's Overview", style: Theme.of(context).textTheme.titleLarge),

        const SizedBox(height: 16),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.25,
          ),
          itemBuilder: (context, index) {
            final card = cards[index];

            return SummaryCard(
              title: card.title,
              value: values[card.id] ?? "--",
              subtitle: card.subtitle,
              icon: card.icon,
              color: card.color,
              enabled: card.enabled,
              onTap: () {
                if (!card.enabled) return;

                debugPrint("${card.id} clicked");
              },
            );
          },
        ),
      ],
    );
  }
}

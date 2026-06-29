import 'package:flutter/material.dart';

import '../../auth/models/user_model.dart';
import '../../sites/models/site_model.dart';

import '../models/dashboard_card_model.dart';

import 'activity_feed_widget.dart';
import 'dashboard_header.dart';
import 'dashboard_summary_widget.dart';
import 'site_selector_widget.dart';

class DashboardBodyWidget extends StatelessWidget {
  final UserModel currentUser;

  final List<SiteModel> sites;
  final SiteModel? selectedSite;

  final ValueChanged<SiteModel?> onSiteChanged;

  final List<DashboardCardModel> dashboardCards;

  final Map<String, String> values;

  const DashboardBodyWidget({
    super.key,
    required this.currentUser,
    required this.sites,
    required this.selectedSite,
    required this.onSiteChanged,
    required this.dashboardCards,
    required this.values,
  });

  String get activeSiteId => selectedSite?.id ?? currentUser.siteId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 110),
        child: Column(
          children: [
            DashboardHeader(userName: currentUser.name),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SiteSelectorWidget(
                    sites: sites,
                    selectedSite: selectedSite,
                    onChanged: onSiteChanged,
                  ),

                  const SizedBox(height: 20),

                  DashboardSummaryWidget(cards: dashboardCards, values: values),

                  const SizedBox(height: 24),

                  ActivityFeedWidget(siteId: activeSiteId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/models/user_model.dart';
import '../../auth/ui/login_screen.dart';

import '../../sites/models/site_model.dart';
import '../../sites/services/site_service.dart';

import '../../user/services/user_service.dart';

import '../../../app/widgets/navigation/expandable_fab.dart';
import '../../../app/widgets/navigation/fab_menu_item.dart';

import '../../../core/constants/dashboard_card_ids.dart';

import '../models/dashboard_card_model.dart';
import '../models/dashboard_overview_model.dart';
import '../models/dashboard_role.dart';

import '../services/dashboard_card_service.dart';
import '../services/dashboard_role_service.dart';
import '../services/dashboard_service.dart';

import '../widgets/dashboard_body_widget.dart';
import '../widgets/dashboard_bottom_nav.dart';
import '../widgets/dashboard_topbar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  bool isLoading = true;

  UserModel? currentUser;

  List<SiteModel> sites = [];
  SiteModel? selectedSite;

  DashboardOverviewModel overview = const DashboardOverviewModel.empty();

  DashboardRole? dashboardRole;

  List<DashboardCardModel> dashboardCards = [];

  final UserService _userService = UserService();
  final SiteService _siteService = SiteService();
  final DashboardService _dashboardService = DashboardService();

  final DashboardRoleService _roleService = const DashboardRoleService();

  final DashboardCardService _cardService = const DashboardCardService();

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    final user = await _userService.getCurrentUser();

    if (user == null || !mounted) return;

    final siteList = await _siteService.getSites(user.companyId);

    final dashboardOverview = await _dashboardService.getOverview(
      companyId: user.companyId,
    );

    SiteModel? activeSite;

    if (siteList.isNotEmpty) {
      activeSite = siteList.firstWhere(
        (site) => site.id == user.siteId,
        orElse: () => siteList.first,
      );
    }

    final role = _roleService.getRole(user.role);

    final cards = _cardService.getCards(role);

    setState(() {
      currentUser = user;
      sites = siteList;
      selectedSite = activeSite;
      overview = dashboardOverview;

      dashboardRole = role;
      dashboardCards = cards;

      isLoading = false;
    });
  }

  void _onSiteChanged(SiteModel? site) {
    if (site == null) return;

    setState(() {
      selectedSite = site;
      currentUser = currentUser!.copyWith(siteId: site.id);
    });
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  Map<String, String> get dashboardValues {
    return {
      DashboardCardIds.users: overview.totalUsers.toString(),

      DashboardCardIds.sites: overview.totalSites.toString(),

      DashboardCardIds.expenses: "--",

      DashboardCardIds.reports: "--",

      DashboardCardIds.workers: "--",

      DashboardCardIds.attendance: "--",

      DashboardCardIds.progress: "--",

      DashboardCardIds.materials: "--",

      DashboardCardIds.stock: "--",

      DashboardCardIds.payments: "--",

      DashboardCardIds.employees: "--",
    };
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (currentUser == null) {
      return const Scaffold(body: Center(child: Text("Session expired")));
    }

    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),

      appBar: DashboardTopBar(
        sites: sites,
        selectedSite: selectedSite,
        onSiteChanged: _onSiteChanged,
        onLogout: _logout,
      ),

      body: DashboardBodyWidget(
        currentUser: currentUser!,
        sites: sites,
        selectedSite: selectedSite,
        onSiteChanged: _onSiteChanged,
        dashboardCards: dashboardCards,
        values: dashboardValues,
      ),

      floatingActionButton: ExpandableFab(
        items: [
          FabMenuItem(icon: Icons.group_add, title: "Add Worker", onTap: () {}),
          FabMenuItem(
            icon: Icons.inventory_2,
            title: "Add Material",
            onTap: () {},
          ),
          FabMenuItem(icon: Icons.payments, title: "Add Expense", onTap: () {}),
          FabMenuItem(
            icon: Icons.fact_check,
            title: "Attendance",
            onTap: () {},
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,

      bottomNavigationBar: DashboardBottomNav(
        selectedIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/models/user_model.dart';
import '../../auth/ui/login_screen.dart';
import 'package:letschat/modules/user/services/user_service.dart';

import '../../sites/models/site_model.dart';
import '../../sites/services/site_service.dart';

import '../widgets/activity_feed_widget.dart';
import '../widgets/dashboard_bottom_nav.dart';
import '../widgets/dashboard_summary_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  UserModel? currentUser;
  bool isLoading = true;

  List<SiteModel> sites = [];
  SiteModel? selectedSite;

  final UserService _userService = UserService();
  final SiteService _siteService = SiteService();

  @override
  void initState() {
    super.initState();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    final user = await _userService.getCurrentUser();

    if (!mounted || user == null) {
      return;
    }

    final siteList = await _siteService.getSites(user.companyId);

    SiteModel? activeSite;

    if (siteList.isNotEmpty) {
      activeSite = siteList.firstWhere(
        (site) => site.id == user.siteId,
        orElse: () => siteList.first,
      );
    }

    if (!mounted) {
      return;
    }

    setState(() {
      currentUser = user;
      sites = siteList;
      selectedSite = activeSite;
      isLoading = false;
    });
  }

  String get activeSiteId => selectedSite?.id ?? currentUser!.siteId;

  void onSiteChanged(SiteModel? site) {
    if (site == null) return;

    setState(() {
      selectedSite = site;
      currentUser = currentUser!.copyWith(siteId: site.id);
    });
  }

  Future<void> _logoutProcess() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text("Session expired. Sign in again.")),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),

      appBar: AppBar(
        title: const Text(
          "ConstructOS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        actions: [
          if (sites.isNotEmpty)
            PopupMenuButton<SiteModel>(
              icon: const Icon(Icons.location_on, color: Colors.blue, size: 28),
              tooltip: "Switch Site",
              initialValue: selectedSite,
              onSelected: onSiteChanged,
              itemBuilder: (context) {
                return sites.map((site) {
                  return PopupMenuItem<SiteModel>(
                    value: site,
                    child: Text(site.name),
                  );
                }).toList();
              },
            )
          else
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Text("No Sites", style: TextStyle(color: Colors.grey)),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: _logoutProcess,
          ),
        ],
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.group_add),
                        title: const Text("Add Worker"),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: const Icon(Icons.inventory),
                        title: const Text("Add Material"),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xffE53935),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Good Morning ☀️",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Welcome, ${currentUser!.name} 👋",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    DashboardSummaryWidget(
                      companyId: currentUser!.companyId,
                      siteId: activeSiteId,
                    ),

                    const SizedBox(height: 24),

                    ActivityFeedWidget(siteId: activeSiteId),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

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

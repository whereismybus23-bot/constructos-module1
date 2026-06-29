import 'package:flutter/material.dart';

import '../../sites/models/site_model.dart';

class DashboardTopBar extends StatelessWidget implements PreferredSizeWidget {
  final List<SiteModel> sites;
  final SiteModel? selectedSite;
  final ValueChanged<SiteModel?> onSiteChanged;
  final VoidCallback onLogout;

  const DashboardTopBar({
    super.key,
    required this.sites,
    required this.selectedSite,
    required this.onSiteChanged,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,

      title: const Text(
        "ConstructOS",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),

      actions: [
        if (sites.isNotEmpty)
          PopupMenuButton<SiteModel>(
            tooltip: "Switch Site",
            initialValue: selectedSite,
            onSelected: onSiteChanged,
            icon: const Icon(Icons.location_on, color: Colors.blue),
            itemBuilder: (context) {
              return sites.map((site) {
                return PopupMenuItem<SiteModel>(
                  value: site,
                  child: Text(site.name),
                );
              }).toList();
            },
          ),

        IconButton(
          tooltip: "Logout",
          onPressed: onLogout,
          icon: const Icon(Icons.logout_rounded, color: Colors.red),
        ),

        const SizedBox(width: 6),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

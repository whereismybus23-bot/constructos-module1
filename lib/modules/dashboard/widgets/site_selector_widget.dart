import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../sites/models/site_model.dart';

class SiteSelectorWidget extends StatelessWidget {
  final List<SiteModel> sites;
  final SiteModel? selectedSite;
  final ValueChanged<SiteModel?> onChanged;

  const SiteSelectorWidget({
    super.key,
    required this.sites,
    required this.selectedSite,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current Site",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 8),

            if (sites.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "No sites available",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                  ),
                ),
              )
            else
              DropdownButtonHideUnderline(
                child: DropdownButton<SiteModel>(
                  value: selectedSite,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),

                  items: sites.map((site) {
                    return DropdownMenuItem<SiteModel>(
                      value: site,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              site.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  onChanged: onChanged,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

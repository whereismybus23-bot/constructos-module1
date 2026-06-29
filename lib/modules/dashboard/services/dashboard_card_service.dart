import 'package:flutter/material.dart';

import '../../../core/constants/dashboard_card_ids.dart';
import '../../../app/theme/app_colors.dart';
import '../models/dashboard_card_model.dart';
import '../models/dashboard_role.dart';

class DashboardCardService {
  const DashboardCardService();

  List<DashboardCardModel> getCards(DashboardRole role) {
    switch (role) {
      case DashboardRole.owner:
        return _ownerCards();

      case DashboardRole.engineer:
        return _engineerCards();

      case DashboardRole.supervisor:
        return _supervisorCards();

      case DashboardRole.storeKeeper:
        return _storeKeeperCards();

      case DashboardRole.accountant:
        return _accountantCards();

      case DashboardRole.hr:
        return _hrCards();
    }
  }

  // ================= OWNER =================

  List<DashboardCardModel> _ownerCards() {
    return const [
      DashboardCardModel(
        id: DashboardCardIds.users,
        title: "Users",
        subtitle: "Company Users",
        icon: Icons.people,
        color: AppColors.info,
      ),
      DashboardCardModel(
        id: DashboardCardIds.sites,
        title: "Sites",
        subtitle: "Construction Sites",
        icon: Icons.location_city,
        color: AppColors.success,
      ),
      DashboardCardModel(
        id: DashboardCardIds.expenses,
        title: "Expenses",
        subtitle: "Coming Soon",
        icon: Icons.currency_rupee,
        color: AppColors.warning,
        enabled: false,
      ),
      DashboardCardModel(
        id: DashboardCardIds.reports,
        title: "Reports",
        subtitle: "Coming Soon",
        icon: Icons.bar_chart,
        color: AppColors.primary,
        enabled: false,
      ),
    ];
  }

  // ================= ENGINEER =================

  List<DashboardCardModel> _engineerCards() {
    return const [
      DashboardCardModel(
        id: DashboardCardIds.workers,
        title: "Workers",
        subtitle: "Coming Soon",
        icon: Icons.groups,
        color: AppColors.info,
      ),
      DashboardCardModel(
        id: DashboardCardIds.attendance,
        title: "Attendance",
        subtitle: "Coming Soon",
        icon: Icons.fact_check,
        color: AppColors.success,
        enabled: false,
      ),
      DashboardCardModel(
        id: DashboardCardIds.progress,
        title: "Progress",
        subtitle: "Coming Soon",
        icon: Icons.trending_up,
        color: AppColors.warning,
        enabled: false,
      ),
    ];
  }

  // ================= SUPERVISOR =================

  List<DashboardCardModel> _supervisorCards() {
    return _engineerCards();
  }

  // ================= STORE KEEPER =================

  List<DashboardCardModel> _storeKeeperCards() {
    return const [
      DashboardCardModel(
        id: DashboardCardIds.materials,
        title: "Materials",
        subtitle: "Coming Soon",
        icon: Icons.inventory,
        color: AppColors.info,
      ),
      DashboardCardModel(
        id: DashboardCardIds.stock,
        title: "Stock",
        subtitle: "Coming Soon",
        icon: Icons.warehouse,
        color: AppColors.success,
        enabled: false,
      ),
    ];
  }

  // ================= ACCOUNTANT =================

  List<DashboardCardModel> _accountantCards() {
    return const [
      DashboardCardModel(
        id: DashboardCardIds.expenses,
        title: "Expenses",
        subtitle: "Coming Soon",
        icon: Icons.currency_rupee,
        color: AppColors.warning,
      ),
      DashboardCardModel(
        id: DashboardCardIds.payments,
        title: "Payments",
        subtitle: "Coming Soon",
        icon: Icons.payments,
        color: AppColors.success,
        enabled: false,
      ),
    ];
  }

  // ================= HR =================

  List<DashboardCardModel> _hrCards() {
    return const [
      DashboardCardModel(
        id: DashboardCardIds.employees,
        title: "Employees",
        subtitle: "Coming Soon",
        icon: Icons.people_alt,
        color: AppColors.info,
      ),
      DashboardCardModel(
        id: DashboardCardIds.attendance,
        title: "Attendance",
        subtitle: "Coming Soon",
        icon: Icons.calendar_month,
        color: AppColors.success,
        enabled: false,
      ),
    ];
  }
}

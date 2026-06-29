class DashboardPermission {
  final bool canManageUsers;
  final bool canManageSites;
  final bool canManageWorkers;
  final bool canManageMaterials;
  final bool canManageExpenses;
  final bool canViewReports;

  const DashboardPermission({
    required this.canManageUsers,
    required this.canManageSites,
    required this.canManageWorkers,
    required this.canManageMaterials,
    required this.canManageExpenses,
    required this.canViewReports,
  });
}

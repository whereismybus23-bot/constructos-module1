class DashboardOverviewModel {
  final int totalUsers;
  final int totalSites;

  const DashboardOverviewModel({
    required this.totalUsers,
    required this.totalSites,
  });

  const DashboardOverviewModel.empty() : totalUsers = 0, totalSites = 0;
}

import '../../../core/constants/user_roles.dart';
import '../models/dashboard_permission.dart';
import '../models/dashboard_role.dart';

class DashboardRoleService {
  const DashboardRoleService();

  /// Convert Firestore role string into DashboardRole enum
  DashboardRole getRole(String role) {
    switch (role.toLowerCase().trim()) {
      case UserRoles.owner:
        return DashboardRole.owner;

      case UserRoles.engineer:
        return DashboardRole.engineer;

      case UserRoles.supervisor:
        return DashboardRole.supervisor;

      // Backward compatibility
      case UserRoles.storeKeeper:
      case 'storekeeper':
      case 'store keeper':
        return DashboardRole.storeKeeper;

      case UserRoles.accountant:
        return DashboardRole.accountant;

      case UserRoles.hr:
        return DashboardRole.hr;

      default:
        return DashboardRole.owner;
    }
  }

  /// Returns permissions for each role
  DashboardPermission getPermissions(DashboardRole role) {
    switch (role) {
      case DashboardRole.owner:
        return const DashboardPermission(
          canManageUsers: true,
          canManageSites: true,
          canManageWorkers: true,
          canManageMaterials: true,
          canManageExpenses: true,
          canViewReports: true,
        );

      case DashboardRole.engineer:
        return const DashboardPermission(
          canManageUsers: false,
          canManageSites: false,
          canManageWorkers: true,
          canManageMaterials: false,
          canManageExpenses: false,
          canViewReports: true,
        );

      case DashboardRole.supervisor:
        return const DashboardPermission(
          canManageUsers: false,
          canManageSites: false,
          canManageWorkers: true,
          canManageMaterials: false,
          canManageExpenses: false,
          canViewReports: true,
        );

      case DashboardRole.storeKeeper:
        return const DashboardPermission(
          canManageUsers: false,
          canManageSites: false,
          canManageWorkers: false,
          canManageMaterials: true,
          canManageExpenses: false,
          canViewReports: true,
        );

      case DashboardRole.accountant:
        return const DashboardPermission(
          canManageUsers: false,
          canManageSites: false,
          canManageWorkers: false,
          canManageMaterials: false,
          canManageExpenses: true,
          canViewReports: true,
        );

      case DashboardRole.hr:
        return const DashboardPermission(
          canManageUsers: false,
          canManageSites: false,
          canManageWorkers: true,
          canManageMaterials: false,
          canManageExpenses: false,
          canViewReports: true,
        );
    }
  }
}

class RoleHelper {
  static bool isOwner(String role) => role == 'owner';

  static bool isAdmin(String role) => role == 'admin';

  static bool isManager(String role) => role == 'manager';

  static bool isWorker(String role) => role == 'worker';

  static bool canAccessAllSites(String role) {
    return role == 'owner' || role == 'admin';
  }
}

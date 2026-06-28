import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // =========================
  // WORKFORCE COUNT
  // =========================
  Stream<int> getWorkersCount(String companyId, String siteId) {
    return _db
        .collection('workers')
        .where('companyId', isEqualTo: companyId)
        .where('siteId', isEqualTo: siteId)
        .snapshots()
        .map((snap) => snap.docs.length);
  }

  // =========================
  // MATERIALS COUNT
  // =========================
  Stream<int> getMaterialsCount(String companyId, String siteId) {
    return _db
        .collection('materials')
        .where('companyId', isEqualTo: companyId)
        .where('siteId', isEqualTo: siteId)
        .snapshots()
        .map((snap) => snap.docs.length);
  }

  // =========================
  // TOTAL EXPENSES
  // =========================
  Stream<double> getTotalExpenses(String companyId, String siteId) {
    return _db
        .collection('expenses')
        .where('companyId', isEqualTo: companyId)
        .where('siteId', isEqualTo: siteId)
        .snapshots()
        .map((snap) {
          double total = 0.0;

          for (final doc in snap.docs) {
            final data = doc.data();
            final amount = data['amount'];

            if (amount is num) {
              total += amount.toDouble();
            }
          }

          return total;
        });
  }

  // =========================
  // PROGRESS %
  // =========================
  Stream<double> getProgress(String companyId, String siteId) {
    return _db
        .collection('projects')
        .where('companyId', isEqualTo: companyId)
        .where('siteId', isEqualTo: siteId)
        .snapshots()
        .map((snap) {
          if (snap.docs.isEmpty) return 0.0;

          int completed = 0;

          for (final doc in snap.docs) {
            final data = doc.data();
            if (data['status'] == 'done') {
              completed++;
            }
          }

          return (completed / snap.docs.length) * 100;
        });
  }
}

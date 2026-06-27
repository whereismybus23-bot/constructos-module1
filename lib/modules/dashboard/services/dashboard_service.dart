import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // WORKERS COUNT
  Stream<int> getWorkersCount(String companyId) {
    return _db
        .collection("workers")
        .where("companyId", isEqualTo: companyId)
        .snapshots()
        .map((snap) => snap.docs.length);
  }

  // MATERIALS COUNT
  Stream<int> getMaterialsCount(String companyId) {
    return _db
        .collection("materials")
        .where("companyId", isEqualTo: companyId)
        .snapshots()
        .map((snap) => snap.docs.length);
  }

  // TOTAL EXPENSES
  Stream<double> getTotalExpenses(String companyId) {
    return _db
        .collection("expenses")
        .where("companyId", isEqualTo: companyId)
        .snapshots()
        .map((snap) {
          double total = 0;

          for (var doc in snap.docs) {
            total += (doc["amount"] ?? 0).toDouble();
          }

          return total;
        });
  }

  // PROGRESS AVERAGE
  Stream<double> getProgress(String companyId) {
    return _db
        .collection("progress")
        .where("companyId", isEqualTo: companyId)
        .snapshots()
        .map((snap) {
          if (snap.docs.isEmpty) return 0;

          double total = 0;

          for (var doc in snap.docs) {
            total += (doc["percentage"] ?? 0).toDouble();
          }

          return total / snap.docs.length;
        });
  }
}

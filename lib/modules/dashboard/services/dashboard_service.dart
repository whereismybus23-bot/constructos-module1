import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/dashboard_overview_model.dart';

class DashboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DashboardOverviewModel> getOverview({
    required String companyId,
  }) async {
    final users = await _firestore
        .collection('companies')
        .doc(companyId)
        .collection('users')
        .get();

    final sites = await _firestore
        .collection('companies')
        .doc(companyId)
        .collection('sites')
        .get();

    return DashboardOverviewModel(
      totalUsers: users.docs.length,
      totalSites: sites.docs.length,
    );
  }
}

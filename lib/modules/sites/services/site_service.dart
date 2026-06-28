import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/site_model.dart';

class SiteService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<SiteModel>> getSites(String companyId) async {
    final snap = await _db
        .collection("sites")
        .where("companyId", isEqualTo: companyId)
        .get();

    return snap.docs
        .map((doc) => SiteModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}

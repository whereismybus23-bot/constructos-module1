import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/worker_model.dart';

class WorkforceService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ADD WORKER
  Future<void> addWorker(WorkerModel worker) async {
    await _db.collection("workers").doc(worker.id).set(worker.toMap());
  }

  // GET WORKERS (REALTIME)
  Stream<List<WorkerModel>> getWorkers(String companyId) {
    return _db
        .collection("workers")
        .where("companyId", isEqualTo: companyId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => WorkerModel.fromMap(doc.data(), doc.id))
              .toList();
        });
  }

  // DELETE WORKER
  Future<void> deleteWorker(String id) async {
    await _db.collection("workers").doc(id).delete();
  }
}

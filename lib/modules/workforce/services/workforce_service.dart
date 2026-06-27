import '../models/worker_model.dart';

class WorkforceService {
  static final List<Worker> workers = [];

  static void addWorker(Worker worker) {
    workers.add(worker);
  }

  static void deleteWorker(String id) {
    workers.removeWhere((w) => w.id == id);
  }

  static void updateWorker(Worker updated) {
    final index = workers.indexWhere((w) => w.id == updated.id);
    if (index != -1) {
      workers[index] = updated;
    }
  }

  static List<Worker> getWorkers() {
    return workers;
  }
}

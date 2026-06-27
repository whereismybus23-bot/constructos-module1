class WorkerModel {
  final String id;
  final String companyId;
  final String name;
  final String phone;
  final String role;
  final double dailyWage;
  final bool isActive;

  WorkerModel({
    required this.id,
    required this.companyId,
    required this.name,
    required this.phone,
    required this.role,
    required this.dailyWage,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "companyId": companyId,
      "name": name,
      "phone": phone,
      "role": role,
      "dailyWage": dailyWage,
      "isActive": isActive,
    };
  }

  factory WorkerModel.fromMap(Map<String, dynamic> map, String id) {
    return WorkerModel(
      id: id,
      companyId: map["companyId"] ?? "",
      name: map["name"] ?? "",
      phone: map["phone"] ?? "",
      role: map["role"] ?? "",
      dailyWage: (map["dailyWage"] ?? 0).toDouble(),
      isActive: map["isActive"] ?? true,
    );
  }
}

class SiteModel {
  final String id;
  final String companyId;
  final String name;

  SiteModel({required this.id, required this.companyId, required this.name});

  factory SiteModel.fromMap(Map<String, dynamic> map, String id) {
    return SiteModel(
      id: id,
      companyId: map['companyId'] ?? '',
      name: map['name'] ?? '',
    );
  }
}

class SiteModel {
  final String siteId;
  final String companyId;
  final String siteName;
  final String address;
  final String city;
  final String state;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  SiteModel({
    required this.siteId,
    required this.companyId,
    required this.siteName,
    required this.address,
    required this.city,
    required this.state,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'siteId': siteId,
      'companyId': companyId,
      'siteName': siteName,
      'address': address,
      'city': city,
      'state': state,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory SiteModel.fromMap(Map<String, dynamic> map) {
    return SiteModel(
      siteId: map['siteId'] ?? '',
      companyId: map['companyId'] ?? '',
      siteName: map['siteName'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      isActive: map['isActive'] ?? true,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}

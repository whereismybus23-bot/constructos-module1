class CompanyModel {
  final String companyId;
  final String companyName;
  final String ownerName;
  final String email;
  final String phone;
  final String gstNumber;
  final String address;
  final String logoUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  CompanyModel({
    required this.companyId,
    required this.companyName,
    required this.ownerName,
    required this.email,
    required this.phone,
    required this.gstNumber,
    required this.address,
    required this.logoUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'companyName': companyName,
      'ownerName': ownerName,
      'email': email,
      'phone': phone,
      'gstNumber': gstNumber,
      'address': address,
      'logoUrl': logoUrl,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      companyId: map['companyId'] ?? '',
      companyName: map['companyName'] ?? '',
      ownerName: map['ownerName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      gstNumber: map['gstNumber'] ?? '',
      address: map['address'] ?? '',
      logoUrl: map['logoUrl'] ?? '',
      isActive: map['isActive'] ?? true,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}

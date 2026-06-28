class UserModel {
  final String uid;
  final String name;
  final String email;
  final String companyId;
  final String siteId;
  final String role;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.companyId,
    required this.siteId,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      companyId: map['companyId'] ?? '',
      siteId: map['siteId'] ?? '',
      role: map['role'] ?? 'worker',
    );
  }

  UserModel copyWith({String? siteId, String? role}) {
    return UserModel(
      uid: uid,
      name: name,
      email: email,
      companyId: companyId,
      siteId: siteId ?? this.siteId,
      role: role ?? this.role,
    );
  }
}

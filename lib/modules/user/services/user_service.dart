import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/models/user_model.dart';
import '../../auth/services/auth_service.dart';

class UserService {
  final AuthService _authService = AuthService();

  Future<UserModel?> getCurrentUser() async {
    final User? firebaseUser = _authService.getCurrentUser();

    if (firebaseUser == null) return null;

    final data = await _authService.getUserData(firebaseUser.uid);

    if (data == null) return null;

    return UserModel.fromMap(data);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String _now() => DateTime.now().toIso8601String();

  void _log(String msg) {
    // replace with logger later
  }

  // =========================
  // REGISTER COMPANY
  // =========================
  Future<String?> registerCompany({
    required String companyName,
    required String ownerName,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCred.user!.uid;

      await _db.collection("companies").doc(uid).set({
        "companyId": uid,
        "companyName": companyName,
        "ownerName": ownerName,
        "phone": phone,
        "email": email,
        "isActive": true,
        "createdAt": _now(),
        "updatedAt": _now(),
      });

      await _db.collection("users").doc(uid).set({
        "uid": uid,
        "companyId": uid,
        "siteId": "default",
        "name": ownerName,
        "email": email,
        "phone": phone,
        "role": "owner",
        "companyName": companyName,
        "isActive": true,
        "createdAt": _now(),
        "updatedAt": _now(),
      });

      return null;
    } on FirebaseAuthException catch (e) {
      _log("AUTH ERROR: ${e.code}");
      _log("AUTH MESSAGE: ${e.message}");

      switch (e.code) {
        case "email-already-in-use":
          return "This email is already registered";
        case "weak-password":
          return "Password should be at least 6 characters";
        case "invalid-email":
          return "Invalid email format";
        default:
          return e.message ?? "Authentication failed";
      }
    } catch (e) {
      _log("REGISTER ERROR: $e");
      return "Error occurred during registration";
    }
  }

  // =========================
  // LOGIN
  // =========================
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = cred.user!.uid;

      final userDoc = await _db.collection("users").doc(uid).get();

      if (!userDoc.exists) {
        return "User data not found";
      }

      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          return "No account found";
        case "wrong-password":
          return "Wrong password";
        case "invalid-credential":
          return "Invalid email or password";
        default:
          return e.message;
      }
    } catch (e) {
      return "Login failed";
    }
  }

  // =========================
  // LOGOUT
  // =========================
  Future<void> logout() async {
    await _auth.signOut();
  }

  // =========================
  // FORGOT PASSWORD
  // =========================
  Future<String?> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Failed to send reset email";
    }
  }

  // =========================
  // CURRENT USER
  // =========================
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // =========================
  // GET USER DATA
  // =========================
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final doc = await _db.collection("users").doc(uid).get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}

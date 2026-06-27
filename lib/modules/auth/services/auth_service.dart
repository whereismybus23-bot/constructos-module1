import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
        "createdAt": FieldValue.serverTimestamp(),
      });

      await _db.collection("users").doc(uid).set({
        "uid": uid,
        "companyId": uid,
        "role": "owner",
        "email": email,
        "createdAt": FieldValue.serverTimestamp(),
      });

      return null;
    } on FirebaseAuthException catch (e) {
      print("AUTH ERROR: ${e.code}");
      print("AUTH MESSAGE: ${e.message}");

      if (e.code == "email-already-in-use") {
        return "This email is already registered";
      }

      if (e.code == "weak-password") {
        return "Password should be at least 6 characters";
      }

      if (e.code == "invalid-email") {
        return "Invalid email format";
      }

      return e.message ?? "Authentication failed";
    } catch (e) {
      print("REGISTER ERROR: $e");
      return "Error: $e";
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

      // fetch user data
      DocumentSnapshot userDoc = await _db.collection("users").doc(uid).get();

      if (!userDoc.exists) {
        return "User data not found";
      }

      return null; // success
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") return "No account found";
      if (e.code == "wrong-password") return "Wrong password";
      return e.message;
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
    } catch (e) {
      return "Failed to send reset email";
    }
  }

  // =========================
  // GET CURRENT USER
  // =========================
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // =========================
  // GET USER DATA (IMPORTANT FOR PHASE 1)
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

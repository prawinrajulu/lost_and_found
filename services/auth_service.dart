import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        return UserModel(
          uid: user.uid,
          email: user.email ?? '',
          displayName: user.displayName ?? '',
        );
      }
    } on FirebaseAuthException catch (e) {
      throw Exception('Login failed: ${e.message}');
    }
    return null;
  }

  Future<UserModel?> signup(String email, String password, String displayName) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(displayName);
        return UserModel(
          uid: user.uid,
          email: user.email ?? '',
          displayName: displayName,
        );
      }
    } on FirebaseAuthException catch (e) {
      throw Exception('Signup failed: ${e.message}');
    }
    return null;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> register(String email, String password, String displayName,
      String familyCode) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final uid = cred.user?.uid;
    if (uid != null) {
      await _firestore.collection('users').doc(uid).set({
        'displayName': displayName,
        'email': email,
        'familyCode': familyCode,
        'fcmTokens': [],
      });
      await _firestore.collection('families').doc(familyCode).set({
        'createdAt': Timestamp.now(),
        'ownerUid': uid,
      });
    }
    return cred.user;
  }

  Future<User?> login(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return cred.user;
  }

  Future<void> saveFcmToken(String uid, String token) async {
    await _firestore.collection('users').doc(uid).update({
      'fcmTokens': FieldValue.arrayUnion([token])
    });
  }

  Future<void> updateFamilyCode(String uid, String familyCode) async {
    await _firestore.collection('users').doc(uid).update({
      'familyCode': familyCode,
    });
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}

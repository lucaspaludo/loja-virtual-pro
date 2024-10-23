import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/helpers/firebase_errors.dart';
import 'package:loja_virtual_pro/models/user.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserData? user;

  bool _loading = false;
  bool get loading => _loading;
  bool get isLoggedIn => user != null;
  Future<void> signIn(
    UserData user, {
    required Function onFail,
    required Function onSucess,
  }) async {
    loading = true;
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      await _loadCurrentUser(firebaseUser: userCredential.user);

      // ignore: avoid_dynamic_calls
      onSucess();
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_dynamic_calls
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp(
    UserData user, {
    required Function onFail,
    required Function onSucess,
  }) async {
    loading = true;
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      user.id = userCredential.user!.uid;
      this.user = user;
      await user.saveData();

      // ignore: avoid_dynamic_calls
      onSucess();
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_dynamic_calls
      onFail(getErrorString(e.code));
    }

    loading = false;
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? firebaseUser}) async {
    final User? currentUser = firebaseUser ?? auth.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      user = UserData.fromDocument(docUser);

      final docAdmin = await firestore.collection('admins').doc(user!.id).get();

      if (docAdmin.exists) {
        user!.admin = true;
      }

      notifyListeners();
    }
  }

  bool get adminEnabled => user != null && user!.admin;
}

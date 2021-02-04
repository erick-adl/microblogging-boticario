import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:microblogging/core/util/firebase_errors.dart';
import 'package:microblogging/features/register/models/user.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  User user;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _loadingGoogle = false;
  bool get loadingGoogle => _loadingGoogle;
  set loadingGoogle(bool value) {
    _loadingGoogle = value;
    notifyListeners();
  }

  bool get isLoggedIn => user != null;

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      await _loadCurrentUser(firebaseUser: result.user);

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> googleLogin({Function onFail, Function onSuccess}) async {
    _loadingGoogle = true;
    try {
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final AuthResult authResult = await auth.signInWithCredential(credential);

      if (authResult.user != null) {
        final firebaseUser = authResult.user;

        user = User(
            id: firebaseUser.uid,
            name: firebaseUser.displayName,
            email: firebaseUser.email);

        await user.saveData();

        user.saveToken();

        onSuccess();
      }
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    _loadingGoogle = false;
  }

  Future<void> signUp({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      user.id = result.user.uid;
      this.user = user;

      await user.saveData();

      user.saveToken();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').document(currentUser.uid).get();
      user = User.fromDocument(docUser);

      user.saveToken();

      notifyListeners();
    }
  }

  bool get adminEnabled => user != null && user.admin;
}

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizzr/Models/CustomUser.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _store = FirebaseFirestore.instance;

  static StreamController<dynamic> userStreamController =
      new StreamController<dynamic>();

  Stream<dynamic> user = userStreamController.stream;

  StreamSubscription<dynamic> _subscription = FirebaseAuth.instance
      .authStateChanges()
      .map((User? user) => _customUserFromFirebaseUser(user))
      .listen((event) {
    userStreamController.sink.add(event);
  });

  static dynamic _customUserFromFirebaseUser(User? user) {
    if (user == null) {
      print('Not signed in');
      return null;
    } else {
      return CustomUser(uid: user.uid, email: user.email);
    }
  }

  void close() {
    userStreamController.close();
    _subscription.cancel();
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      var batch = _store.batch();
      batch.set(_store.collection(user!.uid).doc("quizzes"), {"quizzes": []});
      batch.set(_store.collection(user.uid).doc("participation"),
          {"participation": []});
      await batch.commit();
    } catch (e) {
      throw Exception('Error Registering');
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception('Error signing in');
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error SigningOut");
    }
  }
}

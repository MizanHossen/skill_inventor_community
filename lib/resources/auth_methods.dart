import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skill_inventor_community/models/user.dart' as model;
import 'package:skill_inventor_community/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //Sign in user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register user

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //add image

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePic", file, false);

        // add user database

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          followers: [],
          following: [],
        );

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

        //

        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        res = "The email is badly formatted :-)";
      } else if (e.code == "weak-password") {
        res = "Password should be at least 6 characters :-)";
      }
    } catch (err) {
      res = err.toString();
    }
    //Fluttertoast.showToast(msg: 'Error Occurred: \n $res');
    return res;
  }

  // Login in user
  Future<String> loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = "Success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        res = "Wrong Password";
      } else if (e.code == "invalid-email") {
        res = "The email address is bedly formatted";
      } else if (e.code == "user-not-found") {
        res = "This user not found";
      } else {
        res = e.toString();
      }
    } catch (err) {
      res = err.toString();
    }
    print(res.toString());
    //Fluttertoast.showToast(msg: 'Error Occurred: \n $res');
    return res;
  }
}

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/strorage_methods.dart';

class AuthMethods {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List? imageFile,
  }) async {
    String res = "Some error occurred! Please check you credentials and try later";

    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty || imageFile != null) {
        String imageUrl = await StorageMethods().uploadImageToStorage('profilePics', imageFile!, false);

        final userCred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        _fireStore.collection('users').doc(userCred.user!.uid).set(
          {
            'email': email,
            'username': username,
            'userid': userCred.user!.uid,
            'bio': bio,
            'followers': [],
            'following': [],
            'imageUrl': imageUrl,
          },
        );
        res = 'Account created successfully';
      }
    } on FirebaseAuthException catch (err) {
      res = err.message.toString();
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Somthing went wrong!';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        res = 'Successfully logged in';
        await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        res = 'Please enter username and password';
      }
    } on FirebaseAuthException catch (err) {
      res = err.message.toString();
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}

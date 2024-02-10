import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
    String chilName,
    Uint8List file,
    bool isPost,
  ) async {
    Reference ref = storage.ref().child(chilName).child(auth.currentUser!.uid);

    TaskSnapshot task = await ref.putData(file);

    String downloadUrl = await task.ref.getDownloadURL();
    return downloadUrl;
  }
}

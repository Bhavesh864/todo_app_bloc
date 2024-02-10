import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
  }

  showSnackBar(String message, BuildContext ctx) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.grey,
      ),
    );
  }
}

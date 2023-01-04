import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skill_inventor_community/utils/colors.dart';

pickImage(ImageSource source, BuildContext context) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
    //return File(_file.path); (this is not use for web, so don't use it)
  }

  //print("No image selected");

  // Fluttertoast.showToast(
  //     msg: "No image selected", backgroundColor: primaryColor);

  showSnackBar("No image selected :-)", context);
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: primaryColor,
      content: Text(
        content,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    ),
  );
}

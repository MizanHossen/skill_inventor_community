import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skill_inventor_community/utils/colors.dart';
import 'package:skill_inventor_community/widgets/drop_container.dart';

pickImage(ImageSource source, BuildContext context) async {
  final ImagePicker imagePicker = ImagePicker();

  // ignore: no_leading_underscores_for_local_identifiers
  XFile? _file = await imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
    //return File(_file.path); (this is not use for web, so don't use it)
  }

  //print("No image selected");

  // Fluttertoast.showToast(
  //     msg: "No image selected", backgroundColor: primaryColor);

  // ignore: use_build_context_synchronously
  // showSnackBar("No image selected :-)", context);
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: primaryColor,
      content: DropContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10).copyWith(left: 10),
          child: Text(
            content,
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      ),
    ),
  );
}

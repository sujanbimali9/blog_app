import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final XFile? file =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return null;
    } else {
      return File(file.path);
    }
  } catch (e) {
    return null;
  }
}

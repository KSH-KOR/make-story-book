import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      return image.path;
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
      return null;
    }
    
  }

  Future<List<String>?> pickMultiImages() async {
    try {
      final List<XFile> selectedImages = await ImagePicker().pickMultiImage();
      return selectedImages.map((e) => e.path,).toList();
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
      return null;
    }
  }
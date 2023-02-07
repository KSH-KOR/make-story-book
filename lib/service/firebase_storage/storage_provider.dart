import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

abstract class StorageProvider{
  Future<UploadTask?> getUploadTask({
    required String path,
    required String fileName,
    String? filePathFromLocalDevice,
    File? targetFile,
  });
  Future<String?> getDownloadURL({required UploadTask uploadTask});
  Future<void> showLoadingDialog({
    required UploadTask uploadTask,
    BuildContext? context,
    bool shouldShowLoadingDialog = true,
  });
}
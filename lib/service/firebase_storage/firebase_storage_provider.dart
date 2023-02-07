import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../../presentation/dialogs/loading_dialog.dart';
import 'firebase_storage_exceptions.dart';
import 'storage_provider.dart';

class FirebaseStorageProvider implements StorageProvider{
  final firebaseStorageRef = FirebaseStorage.instance.ref();

  @override
  Future<UploadTask?> getUploadTask({
    required String path,
    required String fileName,
    String? filePathFromLocalDevice,
    File? targetFile,
  }) async {
    if (filePathFromLocalDevice == null && targetFile == null) {
      throw TargetFileNotProvidedException();
    }
    final targetRef = firebaseStorageRef.child(path).child(fileName);
    late final File file;
    if (targetFile == null) {
      file = File(filePathFromLocalDevice!);
      if (!(await file.exists())) throw TargetFilePathNotValidException();
    } else {
      file = targetFile;
    }
    try {
      return targetRef.putFile(file);
    } on FirebaseException catch (e) {
      log("cannot uploaded error msg:${e.code}");
      return null;
    }
  }

  @override
  Future<void> showLoadingDialog({
    required UploadTask uploadTask,
    BuildContext? context,
    bool shouldShowLoadingDialog = true,
  }) async {
    if (shouldShowLoadingDialog && context == null) {
      throw BuildContextNullException();
    }
    if (shouldShowLoadingDialog) {
      loadingDialog(context!, msg: "uploading file to cloud...");
      uploadTask.whenComplete(() => Navigator.of(context).pop());
    }
  }

  @override
  Future<String?> getDownloadURL({required UploadTask uploadTask}) async {
    try {
      final taskSnapshot = await uploadTask;
      log("file uploaded on firebase storage");
      return await taskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      log("cannot uploaded error msg:${e.code}");
      return null;
    }
  }
}

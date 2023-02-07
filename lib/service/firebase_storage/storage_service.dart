import 'package:flutter/src/widgets/framework.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_english_story/service/firebase_storage/firebase_storage_provider.dart';

import 'dart:io';

import 'storage_provider.dart';

class StorageService implements StorageProvider{
  final StorageProvider provider;
  const StorageService(this.provider);

  factory StorageService.firebase() => StorageService(FirebaseStorageProvider());
  @override
  Future<String?> getDownloadURL({required UploadTask uploadTask}) => provider.getDownloadURL(uploadTask: uploadTask);

  @override
  Future<UploadTask?> getUploadTask({required String path, required String fileName, String? filePathFromLocalDevice, File? targetFile}) =>
    getUploadTask(path: path, fileName: fileName, filePathFromLocalDevice: filePathFromLocalDevice, targetFile: targetFile);

  @override
  Future<void> showLoadingDialog({required UploadTask uploadTask, BuildContext? context, bool shouldShowLoadingDialog = true}) =>
    showLoadingDialog(uploadTask: uploadTask, context: context, shouldShowLoadingDialog: shouldShowLoadingDialog);

  Future<String?> uploadFileToFirebaseStorage({required String path, required String fileName, String? filePathFromLocalDevice, File? targetFile, BuildContext? context, bool shouldShowLoadingDialog = true}) async {
    try{
      final UploadTask? uploadTask = await getUploadTask(path: path, fileName: fileName, filePathFromLocalDevice: filePathFromLocalDevice, targetFile: targetFile);
      if(shouldShowLoadingDialog){
        showLoadingDialog(uploadTask: uploadTask!, context: context, shouldShowLoadingDialog: shouldShowLoadingDialog);
      }
      return getDownloadURL(uploadTask: uploadTask!);
    } catch (_){
      rethrow;
    }
  }

}
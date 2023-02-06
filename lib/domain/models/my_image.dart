import 'package:cloud_firestore/cloud_firestore.dart';

class GeneratedImage{
  final String prompt;
  final String? imagUrl;
  final String? imageFirestoreDownloadUrl;
  final Timestamp generatedTime;
  final String storyId;
  final String userId;
  final String imageId;

  GeneratedImage({
    required this.prompt,
    this.imagUrl,
    this.imageFirestoreDownloadUrl,
    required this.generatedTime,
    required this.storyId,
    required this.userId,
    required this.imageId,
  });

  
}
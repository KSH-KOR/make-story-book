import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_english_story/common/constants/firestore_fieldnames/my_image_firestore_fieldname.dart';

class GeneratedImage{
  final String prompt;
  final String? imagUrl;
  final String? imageFirestoreDownloadUrl;
  final Timestamp? generatedServerTime;
  final String userId;
  final String imageId;

  GeneratedImage({
    required this.prompt,
    this.imagUrl,
    this.imageFirestoreDownloadUrl,
    this.generatedServerTime,
    required this.userId,
    required this.imageId,
  });

  Map<String, dynamic> toMap(){
    return {
      myImagePromptFieldName: prompt,
      generatedTimeFieldName: generatedServerTime,
      userIdFieldName: userId,
      myImageIdFieldName: imageId,
      myImageUrlFieldName: imagUrl,
      myImageFirestoreDownloadUrlFieldName: imageFirestoreDownloadUrl,
    };
  }

  factory GeneratedImage.fromMap(Map<String, dynamic> map){
    return GeneratedImage(
      prompt: map[myImagePromptFieldName],
      generatedServerTime: map[generatedTimeFieldName],
      userId: map[userIdFieldName],
      imageId: map[myImageIdFieldName],
      imagUrl: map[myImageUrlFieldName],
      imageFirestoreDownloadUrl: map[myImageFirestoreDownloadUrlFieldName],
    );
  }

  factory GeneratedImage.fromDocSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    final snapShotData = snapshot.data();
    if(snapShotData == null) throw NotRecivedGeneratedImageDataFromQueryRequest();
    return GeneratedImage.fromMap(snapShotData);
  }

  factory GeneratedImage.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot){
    if(!snapshot.exists)  throw NotRecivedGeneratedImageDataFromQueryRequest();
    final snapShotData = snapshot.data();
    return GeneratedImage.fromMap(snapShotData);
  }

}

class NotRecivedGeneratedImageDataFromQueryRequest implements Exception{

}
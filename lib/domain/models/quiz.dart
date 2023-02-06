import 'package:cloud_firestore/cloud_firestore.dart';
import '../../common/constants/firestore_fieldnames/quiz_firestore_fieldname.dart';
import '../../common/extensions/string/maybe_empty.dart';
import '../../common/extensions/int/maybe_zero.dart';

class Quiz{
  final String answer;
  final String prompt;
  final String question;
  final String? quizImgUrl;
  final int quizOrder;

  Quiz({
    required this.answer,
    required this.prompt,
    required this.question,
    required this.quizImgUrl,
    required this.quizOrder,
  });

  factory Quiz.fromSnapshot(
          QueryDocumentSnapshot<Map<String, dynamic>> snapshot) => 
      Quiz(
        answer: MaybeEmpty(snapshot.data()[quizAnswerFieldName]).maybeEmpty(),
        prompt: MaybeEmpty(snapshot.data()[quizPromptFieldName]).maybeEmpty(),
        question: MaybeEmpty(snapshot.data()[quizQuestionFieldName]).maybeEmpty(),
        quizImgUrl: snapshot.data()[quizImgUrlFieldName],
        quizOrder: MaybeZero(snapshot.data()[quizOrderFieldName]).maybeZero(),
      );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_english_story/domain/models/vocab.dart';
import '../../common/constants/firestore_fieldnames/quiz_firestore_fieldname.dart';
import '../../common/extensions/string/maybe_empty.dart';
import '../../common/extensions/int/maybe_zero.dart';

class Quiz{
  final String answer;
  final String prompt;
  final String question;
  final String? quizImgUrl;
  final int quizOrder;
  final String quizId;
  final List<Vocab> answerVocabList;

  Quiz({
    required this.quizId,
    required this.answer,
    required this.prompt,
    required this.question,
    required this.quizImgUrl,
    required this.quizOrder,
    required this.answerVocabList,
  });

  factory Quiz.fromMap(Map<String, dynamic> map){
    return Quiz(
        quizId: MaybeEmpty(map[quizIdFieldName]).maybeEmpty(),
        answer: MaybeEmpty(map[quizAnswerFieldName]).maybeEmpty(),
        prompt: MaybeEmpty(map[quizPromptFieldName]).maybeEmpty(),
        question: MaybeEmpty(map[quizQuestionFieldName]).maybeEmpty(),
        quizImgUrl: map[quizImgUrlFieldName],
        quizOrder: MaybeZero(map[quizOrderFieldName]).maybeZero(),
        answerVocabList: map[quizVocabAnswerFieldName] is Iterable
          ? List.from(map[quizVocabAnswerFieldName])
              .map((element) => Vocab.fromMap(element))
              .toList()
          : [],
      );
  }

  factory Quiz.fromSnapshot(
          QueryDocumentSnapshot<Map<String, dynamic>> snapshot) => 
      Quiz.fromMap(snapshot.data());

       factory Quiz.fromDocSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception();
    }
    final snapshotData = snapshot.data()!;
    return Quiz.fromMap(snapshotData);
  }
}

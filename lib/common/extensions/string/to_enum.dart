import '../../enums/vocab_category.dart';

extension ToVocabCategory<T> on String{
  VocabCategory toVocabCategory() {
    if(isEmpty) return VocabCategory.hasNotBeenDefined;
    return VocabCategory.values.firstWhere((element) => element.toString() == this, orElse: () => VocabCategory.hasNotBeenDefined);
  }
}
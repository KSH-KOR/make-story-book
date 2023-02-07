extension SplitContainingPatterns on String{
  List<String> splitContainingPatterns({required Pattern pattern, bool shouldTrim = true}){
    int length = this.length;
    Iterator iterator = pattern.allMatches(this).iterator;
    if (length == 0 && iterator.moveNext()) {
      return <String>[];
    }
    List<String> result = <String>[];
    int startIndex = 0;
    int previousIndex = 0;
    while (true) {
      if (startIndex == length || !iterator.moveNext()) {
        result.add(substring(previousIndex, length));
        break;
      }
      Match match = iterator.current;
      if (match.start == length) {
        result.add(substring(previousIndex, length));
        break;
      }
      int endIndex = match.end;
      if (startIndex == endIndex && endIndex == previousIndex) {
        ++startIndex;
        continue;
      }
      
      result.add(substring(previousIndex, match.start));
      result.add(shouldTrim ? substring(match.start, match.end).trim() : substring(match.start, match.end));
      startIndex = previousIndex = endIndex;
    }
    return result;
  }
}
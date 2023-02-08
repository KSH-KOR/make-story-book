
class TargetFileNotProvidedException implements Exception{
  @override
  String toString() {
    return "TargetFileNotProvidedException";
  }
}

class TargetFilePathNotValidException implements Exception{
  @override
  String toString() {
    return "TargetFilePathNotValidException";
  }
}

class BuildContextNullException implements Exception{
  @override
  String toString() {
    return "pass build context if you want to show loading dialog";
  }
}
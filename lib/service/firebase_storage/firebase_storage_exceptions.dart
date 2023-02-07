import 'dart:html';

class TargetFileNotProvidedException implements Exception{
  @override
  String toString() {
    return "${super} : TargetFileNotProvidedException";
  }
}

class TargetFilePathNotValidException implements Exception{
  @override
  String toString() {
    return "${super} : TargetFilePathNotValidException";
  }
}

class BuildContextNullException implements Exception{
  @override
  String toString() {
    return "${super} : pass build context if you want to show loading dialog";
  }
}
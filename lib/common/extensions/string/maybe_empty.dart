extension MaybeEmpty on String?{
  String maybeEmpty(){
    return this != null ? this! : "";
  }
}

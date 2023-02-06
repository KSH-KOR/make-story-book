extension MaybeZero on int?{
  int maybeZero(){
    return this != null ? this! : 0;
  }
}
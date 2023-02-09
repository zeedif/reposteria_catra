bool isValidUsername(String text){
  return RegExp(r"^[A-Za-z0-9\u00C0-\u017F ]+$").hasMatch(text);
}
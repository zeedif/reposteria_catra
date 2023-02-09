bool isValidNumero(String text){
  return RegExp(r"^(\d){0,6}$").hasMatch(text);
}
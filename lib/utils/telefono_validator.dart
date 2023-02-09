bool isValidTelefono(String text){
  return RegExp(r"(^(?:[+0]9)?[0-9]{10,12}$)").hasMatch(text);
}
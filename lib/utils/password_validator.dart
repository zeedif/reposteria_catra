bool isValidPassword(String text){
  return RegExp(r"^(?=.*[A-Za-z])(?=.*?[0-9])(?=\S+$).{6,16}$").hasMatch(text);
}
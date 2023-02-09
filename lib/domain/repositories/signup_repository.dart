import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpRepository {
  Future<SignUpResponse> register(SignUpData data);
}

class SignUpData {
  final String username, email, password;

  SignUpData({
    required this.username,
    required this.email,
    required this.password,
  });
}

class SignUpResponse {
  final SignUpError? error;
  final User? user;

  SignUpResponse(this.error, this.user);
}

SignUpError parseStringToSignUpError(String text){
  switch(text){
    case "email-already-in-use":
    return SignUpError.emailAlreadyInUse;
    case "weak-password":
    return SignUpError.weakPassword;
    case "network-request-failed":
    return SignUpError.networkRequestFailed;
    default:
    return SignUpError.unknown;
  }
}

enum SignUpError{
  emailAlreadyInUse,
  weakPassword,
  networkRequestFailed,
  unknown
}
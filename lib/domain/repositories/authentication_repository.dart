import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<User?> get user;
  Future<void> signOut();
  Future<SignInResponse> signInWithEmailAndPassword(
    String email,
    String password,
  );
}

class SignInResponse {
  final SignInError? error;
  final User? user;

  SignInResponse(this.error, this.user);
}

SignInError parseStringToSignInError(String text){
  switch(text){
    case "user-disabled":
    return SignInError.userDisabled;
    case "user-not-found":
    return SignInError.userNotFound;
    case "wrong-password":
    return SignInError.wrongPassword;
    case "network-request-failed":
    return SignInError.networkRequestFailed;
    case "too-many-requests":
    return SignInError.tooManyRequests;
    default:
    return SignInError.unknown;
  }
}

enum SignInError{
  networkRequestFailed,
  userDisabled,
  userNotFound,
  wrongPassword,
  tooManyRequests,
  unknown,
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reposteria_catra/domain/repositories/signup_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final FirebaseAuth _auth;

  SignUpRepositoryImpl(this._auth);
  @override
  Future<SignUpResponse> register(SignUpData data) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );
      //await userCredential.user!.updateDisplayName("${data.name} ${data.lastname}",);
      await userCredential.user!.updateDisplayName(data.username,);
      return SignUpResponse(null, userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(parseStringToSignUpError(e.code), null);
    }
  }
}

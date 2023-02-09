import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:reposteria_catra/data/repositories_impl/authentication_repository_impl.dart';
import 'package:reposteria_catra/data/repositories_impl/signup_repository_impl.dart';
import 'package:reposteria_catra/domain/repositories/authentication_repository.dart';
import 'package:reposteria_catra/domain/repositories/signup_repository.dart';

void injectDependencies() {
  Get.lazyPut<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(FirebaseAuth.instance),
  );
  Get.lazyPut<SignUpRepository>(
    () => SignUpRepositoryImpl(FirebaseAuth.instance),
  );
}

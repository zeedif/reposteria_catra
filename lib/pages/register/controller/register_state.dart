import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.freezed.dart';
@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState ({
    @Default('') String email,
    @Default('') String password,
    @Default('') String vPassword,
    @Default('') String username,
  }) = _RegisterState;

  static RegisterState get initialState => const RegisterState();
}
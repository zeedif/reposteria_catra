import 'package:freezed_annotation/freezed_annotation.dart';
part 'payment_state.freezed.dart';
@freezed
class PaymentState with _$PaymentState {
  factory PaymentState({
    @Default('') String nombres,
    @Default('') String apellidos,
    @Default('') String calle,
    @Default(0) int numeroExterior,
    @Default(0) int numeroInterior,
    @Default('') String colonia,
    @Default(0) int codigoPostal,
    @Default('') String telefono,
    @Default('') String correo,
    @Default('') String metodoPago
  }) = _PaymentState;
  static PaymentState initialState = PaymentState();
}
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter/widgets.dart';
import 'package:reposteria_catra/global_controller/productos_controller.dart';
import 'package:reposteria_catra/pages/payment/controller/payment_state.dart';
import 'package:reposteria_catra/widgets/progress_dialog.dart';

class PaymentController extends StateNotifier<PaymentState> {
  PaymentController() : super(PaymentState.initialState);
  final GlobalKey<FormState> formKey = GlobalKey();

  Future<void> submit(BuildContext context) async {
    final controller = productosProvider.read;
    ProgressDialog.show(context);
    Map<String, dynamic> datos = {
      'nombres': state.nombres,
      'apellidos': state.apellidos,
      'calle': state.calle,
      'numero_ext': state.numeroExterior,
      'colonia': state.colonia,
      'numero_int': state.numeroInterior,
      'cp': state.codigoPostal,
      'telefono': state.telefono,
      'correo': state.correo,
      'metodo': state.metodoPago,
    };
    controller.guardarPedido(datos);
    router.pop();
    await Future.delayed(const Duration(milliseconds: 200));
    router.pop();
  }

  void onNombreChanged(String text) {
    state = state.copyWith(nombres: text);
  }

  void onApellidosChanged(String text) {
    state = state.copyWith(apellidos: text);
  }

  void onCalleChanged(String text) {
    state = state.copyWith(calle: text);
  }

  void onNumeroExteriorChanged(int i) {
    state = state.copyWith(numeroExterior: i);
  }

  void onColoniaChanged(String text) {
    state = state.copyWith(colonia: text);
  }

  void onNumeroInteriorChanged(int i) {
    state = state.copyWith(numeroInterior: i);
  }

  void onCodigoPostalChanged(int i) {
    state = state.copyWith(codigoPostal: i);
  }

  void onTelefonoChanged(String text) {
    state = state.copyWith(telefono: text);
  }

  void onCorreoChanged(String text) {
    state = state.copyWith(correo: text);
  }

  void onMetodoPagoChanged(String text) {
    state = state.copyWith(metodoPago: text);
  }
}

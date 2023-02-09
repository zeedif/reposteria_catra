// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:reposteria_catra/domain/repositories/authentication_repository.dart';
import 'package:reposteria_catra/pages/login/login_page.dart'
    show loginProvider;
import 'package:reposteria_catra/routes/routes.dart';
import 'package:reposteria_catra/widgets/dialogs.dart';
import 'package:reposteria_catra/widgets/progress_dialog.dart';

Future<void> sendLoginForm(BuildContext context) async {
  final controller = loginProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();

  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      late String content = "";
      switch (response.error) {
        case SignInError.userDisabled:
          content = "¡El usuario está deshabilitado!";
          break;
        case SignInError.userNotFound:
          content = "¡No se ha encontrado el usuario!";
          break;
        case SignInError.wrongPassword:
          content = "¡La contraseña es incorrecta!";
          break;
        case SignInError.networkRequestFailed:
          content = "¡No hay conexión a internet!";
          break;
        case SignInError.tooManyRequests:
          content = "¡Ha excedido el número de intentos!";
          break;
        case SignInError.unknown:
        default:
          content = "Error desconocido.";
          break;
      }
      Dialogs.alert(
        context,
        title: "Error",
        content: content,
      );
    } else {
      router.pushReplacementNamed(Rutas.HOME);
    }
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:reposteria_catra/domain/repositories/signup_repository.dart';
import 'package:reposteria_catra/pages/register/register_page.dart'
    show registerProvider;
import 'package:reposteria_catra/routes/routes.dart';
import 'package:reposteria_catra/widgets/dialogs.dart';
import 'package:reposteria_catra/widgets/progress_dialog.dart';

Future<void> sendRegister(BuildContext context) async {
  final controller = registerProvider.read;
  final isValidForm = controller.formKey.currentState!.validate();

  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      late String content = "";
      switch (response.error) {
        case SignUpError.emailAlreadyInUse:
          content = "¡El correo ya esta registrado!";
          break;
        case SignUpError.weakPassword:
          content = "¡La contraseña es muy debil!";
          break;
        case SignUpError.networkRequestFailed:
          content = "¡No hay conexión a internet!";
          break;
        case SignUpError.unknown:
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
      router.pushNamedAndRemoveUntil(
        Rutas.HOME,
      );
    }
  } else {
    Dialogs.alert(
      context,
      title: "Error",
      content: "Campos invalidos",
    );
  }
}

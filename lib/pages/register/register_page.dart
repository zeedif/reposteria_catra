import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:reposteria_catra/global_controller/productos_controller.dart';
import 'package:reposteria_catra/global_controller/session_controller.dart';
import 'package:reposteria_catra/pages/register/controller/register_controller.dart';
import 'package:reposteria_catra/routes/routes.dart';
import 'package:reposteria_catra/utils/password_validator.dart';
import 'package:reposteria_catra/utils/email_validator.dart';
import 'package:reposteria_catra/utils/send_register_form.dart';
import 'package:reposteria_catra/utils/username_validator.dart';
import 'package:reposteria_catra/widgets/inputs_text.dart';
import 'package:reposteria_catra/pages/register/controller/register_state.dart';

final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read,productosProvider.read),
);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              constraints: const BoxConstraints.expand(),
              child: Center(
                child: Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Form(
                    key: controller.formKey,
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      children: <Widget>[
                        ListTile(
                          title: SizedBox(
                            height: 100.0,
                            width: 100.0,
                            child: Image.asset(
                                'assets/logo.png'),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: const Text(
                            "Repostería Catra",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        InputText(
                          label: "Escribe tu usuario...",
                          validator: (text) {
                            //if (text == null) return "Usuario invalido";
                            return isValidUsername(text!)
                                ? null
                                : "Usuario invalido";
                          },
                          onChanged: controller.onUsernameChanged,
                        ),
                        InputText(
                          inputType: TextInputType.emailAddress,
                          label: "Escribe tu correo...",
                          validator: (text) {
                            //if (text == null) return 'Correo invalido';
                            return isValidEmail(text!)
                                ? null
                                : 'Correo invalido';
                          },
                          onChanged: controller.onEmailChanged,
                        ),
                        InputText(
                          label: "Escribe tu contraseña...",
                          isPassword: true,
                          validator: (text) {
                            //if (text == null) return "Contraseña invalida. Necesita:\n* Tener al menos una letra y un número.\n* No contener espacios.\n* Medir de 6 a 16 caracteres.";
                            return isValidPassword(text!)
                                ? null
                                : "Contraseña invalida. Necesita:\n* Tener al menos una letra y un número.\n* No contener espacios.\n* Medir de 6 a 16 caracteres.";
                          },
                          onChanged: controller.onPasswordChanged,
                        ),
                        Consumer(
                          builder: (_, watch, __) {
                            watch.watch(
                                registerProvider.select((_) => _.password));
                            return InputText(
                              label: "Confirma tu contraseña...",
                              isPassword: true,
                              validator: (text) {
                                //if (text == null) return "Contraseña invalida.";
                                if (controller.state.password != text) {
                                  return "Las contraseñas no coinciden";
                                }
                                return isValidPassword(text!)
                                    ? null
                                    : "Contraseña invalida.";
                              },
                              onChanged: controller.onVPasswordChanged,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            sendRegister(context);
                          },
                          color: Colors.pink,
                          shape: const StadiumBorder(),
                          height: 45,
                          child: const Text(
                            "Registrar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: const Text(
                            "¿Ya tienes una cuenta registrada?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                    router.pushNamedAndRemoveUntil(Rutas.LOGIN);
                          },
                          color: Colors.grey,
                          shape: const StadiumBorder(),
                          height: 45,
                          child: const Text(
                            "Inicia sesión",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

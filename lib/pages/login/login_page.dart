import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:reposteria_catra/global_controller/productos_controller.dart';
import 'package:reposteria_catra/global_controller/session_controller.dart';
import 'package:reposteria_catra/pages/login/controller/login_controller.dart';
import 'package:reposteria_catra/routes/routes.dart';
import 'package:reposteria_catra/utils/password_validator.dart';
import 'package:reposteria_catra/utils/email_validator.dart';
import 'package:reposteria_catra/utils/send_login_form.dart';
import 'package:reposteria_catra/widgets/inputs_text.dart';

final loginProvider = SimpleProvider<LoginController>(
  (_) => LoginController(sessionProvider.read,productosProvider.read),
);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<LoginController>(
      provider: loginProvider,
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
                  color: Colors.white,
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
                          label: "Escribe tu correo...",
                          onChanged: controller.onEmailChanged,
                          inputType: TextInputType.emailAddress,
                          validator: (text){
                            //if (text == null) return 'Correo invalido';
                            return isValidEmail(text!)
                                ? null
                                : 'Correo invalido';
                          },
                        ),
                        InputText(
                          label: "Escribe tu contraseña...",
                          isPassword: true,
                          onChanged: controller.onPasswordChanged,
                          validator: (text){
                            //if (text == null) return "Contraseña invalida. Necesita:\n* Tener al menos una letra y un número.\n* No contener espacios.\n* Medir de 6 a 16 caracteres.";
                            return isValidPassword(text!)
                                ? null
                                : "Contraseña invalida. Necesita:\n* Tener al menos una letra y un número.\n* No contener espacios.\n* Medir de 6 a 16 caracteres.";
                          },
                        ),
                        const SizedBox(height: 10),
                        MaterialButton(
                          onPressed: (){sendLoginForm(context);},
                          color: Colors.pink,
                          shape: const StadiumBorder(),
                          height: 45,
                          child: const Text(
                            "Ingresar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: const Text(
                            "¿No tienes una cuenta registrada?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            router.pushNamedAndRemoveUntil(Rutas.REGISTER);
                          },
                          color: Colors.grey,
                          shape: const StadiumBorder(),
                          height: 45,
                          child: const Text(
                            "Regístrate",
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

import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:reposteria_catra/utils/cp_validator.dart';
import 'package:reposteria_catra/utils/email_validator.dart';
import 'package:reposteria_catra/utils/numero_validator.dart';
import 'package:reposteria_catra/utils/telefono_validator.dart';
import 'package:reposteria_catra/widgets/dialogs.dart';
import 'package:reposteria_catra/widgets/inputs_text.dart';

import 'controller/payment_controller.dart';
import 'controller/payment_state.dart';

final paymentProvider = StateProvider<PaymentController, PaymentState>(
  (_) => PaymentController(),
);

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderListener<PaymentController>(
      provider: paymentProvider,
      builder: (_, controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.brown.shade700,
          appBar: AppBar(
            title: const Text("Formulario de dirección"),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              constraints: const BoxConstraints.expand(),
              child: Center(
                child: Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Form(
                    key: controller.formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: const Text(
                                "Ingrese su dirección de envío",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            InputText(
                              label: "Escribe tu nombre...",
                              validator: (text) {
                                return (text!.isNotEmpty)
                                    ? null
                                    : "Nombre invalido";
                              },
                              onChanged: controller.onNombreChanged,
                            ),
                            InputText(
                              label: "Escribe tu apellido...",
                              validator: (text) {
                                return (text!.isNotEmpty)
                                    ? null
                                    : "Apellido invalido";
                              },
                              onChanged: controller.onApellidosChanged,
                            ),
                            InputText(
                              label: "Escribe tu número exterior...",
                              inputType: TextInputType.phone,
                              validator: (text) {
                                return (isValidNumero(text!) && text.isNotEmpty)
                                    ? null
                                    : "Número invalido";
                              },
                              onChanged: (text) {
                                controller
                                    .onNumeroExteriorChanged(int.parse(text));
                              },
                            ),
                            InputText(
                              label: "Escribe tu número interior...",
                              inputType: TextInputType.phone,
                              validator: (text) {
                                return isValidNumero(text!)
                                    ? null
                                    : "Número invalido";
                              },
                              onChanged: (text) {
                                controller.onNumeroInteriorChanged(
                                    text.isEmpty ? null : int.parse(text));
                              },
                            ),
                            InputText(
                              label: "Escribe tu calle...",
                              validator: (text) {
                                return (text!.isNotEmpty)
                                    ? null
                                    : "Calle invalida";
                              },
                              onChanged: controller.onCalleChanged,
                            ),
                            InputText(
                              label: "Escribe tu código postal...",
                              inputType: TextInputType.phone,
                              validator: (text) {
                                return isValidCP(text!)
                                    ? null
                                    : "Código postal invalido";
                              },
                              onChanged: (text) {
                                controller
                                    .onCodigoPostalChanged(int.parse(text));
                              },
                            ),
                            InputText(
                              label: "Escribe tu colonia...",
                              validator: (text) {
                                return (text!.isNotEmpty)
                                    ? null
                                    : "Colonia invalida";
                              },
                              onChanged: controller.onColoniaChanged,
                            ),
                            InputText(
                              label: "Escribe tu teléfono...",
                              inputType: TextInputType.phone,
                              validator: (text) {
                                return isValidTelefono(text!)
                                    ? null
                                    : "Teléfono invalido";
                              },
                              onChanged: controller.onTelefonoChanged,
                            ),
                            InputText(
                              label: "Escribe tu correo electrónico...",
                              inputType: TextInputType.emailAddress,
                              validator: (text) {
                                return isValidEmail(text!)
                                    ? null
                                    : "Correo electrónico invalido";
                              },
                              onChanged: controller.onCorreoChanged,
                            ),
                            InputText(
                              label: "Escribe tu método de pago...",
                              validator: (text) {
                                return (text!.isNotEmpty)
                                    ? null
                                    : "Método de pago invalido";
                              },
                              onChanged: controller.onMetodoPagoChanged,
                            ),
                            MaterialButton(
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text("Confirmación"),
                                      content: const Text(
                                          "¿Está seguro que desea realizar la compra?"),
                                      actions: [
                                        MaterialButton(
                                          child: const Text("Cancelar"),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        MaterialButton(
                                          child: const Text("Confirmar"),
                                          onPressed: () {
                                            controller.submit(context);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  Dialogs.alert(
                                    context,
                                    title: "Error",
                                    content: "Campos invalidos",
                                  );
                                }
                              },
                              color: Colors.pink,
                              shape: const StadiumBorder(),
                              height: 45,
                              child: const Text(
                                "Comprar",
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
            ),
          ),
        );
      },
    );
  }
}

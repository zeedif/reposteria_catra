import 'package:flutter_meedu/ui.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;
import 'package:reposteria_catra/domain/models/pedidos.dart';
import 'package:reposteria_catra/global_controller/pedidos_controller.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, pedidosController, __) {
        final provider = pedidosController.watch(pedidosProvider);
        List<Pedidos> pedidos = provider.getPedidos();
        pedidos.sort((a, b) => b.fecha.compareTo(a.fecha));
        return SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Pedidos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pedidos.length,
                itemBuilder: (_, int i) {
                  String estado = "";
                  switch (pedidos[i].estado) {
                    case 1:
                      estado = "Pendiente";
                      break;
                    case 2:
                      estado = "Enviado";
                      break;
                    case 3:
                      estado = "Entregado";
                      break;
                    default:
                      estado = "Cancelado";
                  }
                  return ExpansionTile(
                    collapsedTextColor: Colors.white,
                    textColor: Colors.purple.shade100,
                    //Aquí es-MX
                    title: Text(
                        "Pedido: ${DateFormat.yMMMd().add_jm().format(pedidos[i].fecha)}"),
                    backgroundColor: Colors.purple.shade100,
                    children: [
                      Text(
                          "Nombre: ${pedidos[i].nombres} ${pedidos[i].apellidos}"),
                      Text(
                          "Dirección: ${pedidos[i].calle} #${pedidos[i].numeroExt}, colonia ${pedidos[i].colonia}, CP. ${pedidos[i].cp}"),
                      Text("Teléfono: ${pedidos[i].telefono}"),
                      Text("Correo: ${pedidos[i].correo}"),
                      Text("Estado: $estado"),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: pedidos[i].productos.length,
                        itemBuilder: (_, int j) {
                          return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.brown.shade400),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)), // Image border
                                    child: SizedBox.fromSize(
                                      size: const Size(75, 75), // Image radius
                                      child: Image.network(
                                          pedidos[i].productos[j].img,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          pedidos[i]
                                              .productos[j]
                                              .name
                                              .toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        ),
                                        Text(
                                          "Sabor: ${pedidos[i].productos[j].sabor}\nCantidad: ${pedidos[i].productos[j].cantidad}",
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color:
                                                Colors.pink.withOpacity(0.65),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "\$${(pedidos[i].productos[j].precio * pedidos[i].productos[j].cantidad).toStringAsFixed(2)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        ?.copyWith(color: Colors.pink),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

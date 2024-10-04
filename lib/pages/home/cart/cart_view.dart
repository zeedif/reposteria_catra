import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:reposteria_catra/domain/models/productos.dart';
import 'package:reposteria_catra/global_controller/productos_controller.dart';
import 'package:reposteria_catra/routes/routes.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, productosController, __) {
        final provider = productosController.watch(productosProvider);
        List<Productos> productos = provider.getProductosSeleccionados();
        return Column(
          children: [
            const Text(
              "Carrito",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: productos.length,
              itemBuilder: (_, int index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.brown.shade400),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(15)), // Image border
                          child: SizedBox.fromSize(
                            size: const Size(75, 75), // Image radius
                            child: Image.network(productos[index].img,
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productos[index].name.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                "Sabor: ${productos[index].sabor}\nCantidad: ${productos[index].cantidad}",
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.pink.withOpacity(0.65),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${(productos[index].precio * productos[index].cantidad).toStringAsFixed(2)}",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.pink),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(
                            Icons.remove,
                            color: Theme.of(context).primaryColor,
                          ),
                          highlightColor: Colors.transparent,
                          iconSize: 32.0,
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            provider.removeProducto(productos[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                          ),
                          highlightColor: Colors.transparent,
                          iconSize: 32.0,
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            provider.addProducto(productos[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            //if cart is empty, show a message
            if (productos.isEmpty)
              const Center(
                child: Text(
                  "No hay productos en el carrito",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              )
            else
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Rutas.PAYMENT);
                },
                color: Colors.purple.shade300,
                child: const Text("Comprar"),
              ),
          ],
        );
      },
    );
  }
}

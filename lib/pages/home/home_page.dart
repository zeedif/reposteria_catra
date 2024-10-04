import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:reposteria_catra/global_controller/productos_controller.dart';
import 'package:reposteria_catra/global_controller/session_controller.dart';
import 'package:reposteria_catra/pages/home/cart/cart_view.dart';
import 'package:reposteria_catra/pages/home/home_controller.dart';
import 'package:reposteria_catra/pages/home/orders/orders_view.dart';
import 'package:reposteria_catra/routes/routes.dart';
import 'catalog/catalog_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade700,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Catra'),
            )
          ],
        ),
        actions: <Widget>[
          InkWell(
            splashColor: const Color.fromARGB(255, 186, 104, 200),
            onTap: () {
              homeProvider.read.cambiarPantalla(0);
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                double size = constraints.maxHeight;
                return SizedBox(
                  width: size,
                  height: size,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.cube_box_fill),
                      Text("Pedidos"),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            splashColor: const Color.fromARGB(255, 186, 104, 200),
            onTap: () {
              homeProvider.read.cambiarPantalla(2);
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                double size = constraints.maxHeight;
                return SizedBox(
                  width: size,
                  height: size,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.cart_fill),
                      Text("Carrito"),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            splashColor: const Color.fromARGB(255, 186, 104, 200),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Advertencia"),
                  content: const Text("¿Esta seguro qué quiere cerrar sesión?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancelar"),
                    ),
                    TextButton(
                      onPressed: () async {
                        //Eliminar las listas de productos
                        productosProvider.read.resetProductosToDefaults();
                        await sessionProvider.read.signOut();
                        router.pushNamedAndRemoveUntil(Rutas.LOGIN);
                      },
                      child: const Text("Aceptar"),
                    ),
                  ],
                ),
              );
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                double size = constraints.maxHeight;
                return SizedBox(
                  width: size,
                  height: size,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout),
                      Text("Salir"),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: PageView(
        controller: homeProvider.read.scrollControl,
        onPageChanged: (int i) {
          homeProvider.read.currentPage = i;
        },
        children: const <Widget>[
          OrdersView(),
          CatalogView(),
          CartView(),
        ],
      ),
    );
  }
}

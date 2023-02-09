import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:reposteria_catra/domain/models/productos.dart';
import 'package:reposteria_catra/global_controller/productos_controller.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(builder: (_, productosController, __) {
    final pasteles =
        productosController.watch(productosProvider).getPasteles();
    final galletas =
        productosController.watch(productosProvider).getGalletas();
    final brownies =
        productosController.watch(productosProvider).getBrownies();
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: size.height * 0.2,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 48),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/header.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.55),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(15))),
              padding: const EdgeInsets.all(12),
              child: Text(
                "¡Bienvenido/a!",
                style: Theme.of(context).textTheme.headline3?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: Text(
              "Selecciona los productos que desea llevar:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ),
          ),
          const _ProductosTitulo(texto: 'Pasteles'),
          _ProductosSlider(size: size, productos: pasteles),
          const _ProductosTitulo(texto: 'Galletas'),
          _ProductosSlider(size: size, productos: galletas),
          const _ProductosTitulo(texto: 'Brownies'),
          _ProductosSlider(size: size, productos: brownies),
        ],
      ),
    );
          });
  }
}

class _ProductosTitulo extends StatelessWidget {
  const _ProductosTitulo({
    Key? key,
    required this.texto,
  }) : super(key: key);
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Text(
        texto,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class _ProductosSlider extends StatelessWidget {
  const _ProductosSlider({
    Key? key,
    required this.size,
    required this.productos,
  }) : super(key: key);

  final Size size;
  final List<Productos> productos;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productos.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              productosProvider.read.seleccionarProductos(productos[index]);
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              width: 170,
              decoration: BoxDecoration(
                border: productos[index].isSelected
                    ? Border.all(color: Colors.pink, width: 3)
                    : null,
                borderRadius: BorderRadius.circular(17),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ), // Image border
                    child: SizedBox.fromSize(
                      size: const Size(170, 170), // Image radius
                      child: Image.network(productos[index].img,
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 8),
                          blurRadius: 8,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productos[index].name.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.button,
                              ),
                              Text(
                                "Sabor: ${productos[index].sabor}",
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
                          "\$${productos[index].precio}",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: Colors.pink),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

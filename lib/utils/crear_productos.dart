import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reposteria_catra/domain/models/productos.dart';

Future<void> cargarProductosIniciales() async {
  final _instance = FirebaseFirestore.instance;
  CollectionReference productosCollection = _instance.collection('productos');

  await _verificarOCargarSubcoleccion(productosCollection, 'pasteles', [
    Productos(
      name: "Pastel de Chocolate",
      precio: 150.0,
      img: "https://picsum.photos/500/300",
      sabor: "Chocolate",
      estado: 1,
      cantidad: 5,
      isSelected: false,
    ),
    Productos(
      name: "Pastel de Vainilla",
      precio: 130.0,
      img: "https://picsum.photos/500/300",
      sabor: "Vainilla",
      estado: 1,
      cantidad: 3,
      isSelected: false,
    ),
    Productos(
      name: "Pastel de Fresa",
      precio: 140.0,
      img: "https://picsum.photos/500/300",
      sabor: "Fresa",
      estado: 1,
      cantidad: 2,
      isSelected: false,
    ),
    Productos(
      name: "Pastel Red Velvet",
      precio: 160.0,
      img: "https://picsum.photos/500/300",
      sabor: "Red Velvet",
      estado: 1,
      cantidad: 4,
      isSelected: false,
    ),
    Productos(
      name: "Pastel de Tres Leches",
      precio: 170.0,
      img: "https://picsum.photos/500/300",
      sabor: "Tres Leches",
      estado: 1,
      cantidad: 5,
      isSelected: false,
    )
  ]);

  await _verificarOCargarSubcoleccion(productosCollection, 'galletas', [
    Productos(
      name: "Galletas de Avena",
      precio: 50.0,
      img: "https://picsum.photos/500/300",
      sabor: "Avena",
      estado: 1,
      cantidad: 10,
      isSelected: false,
    ),
    Productos(
      name: "Galletas de Chispas de Chocolate",
      precio: 45.0,
      img: "https://picsum.photos/500/300",
      sabor: "Chocolate",
      estado: 1,
      cantidad: 15,
      isSelected: false,
    ),
    Productos(
      name: "Galletas de Mantequilla",
      precio: 40.0,
      img: "https://picsum.photos/500/300",
      sabor: "Mantequilla",
      estado: 1,
      cantidad: 12,
      isSelected: false,
    ),
    Productos(
      name: "Galletas de Almendra",
      precio: 55.0,
      img: "https://picsum.photos/500/300",
      sabor: "Almendra",
      estado: 1,
      cantidad: 8,
      isSelected: false,
    ),
    Productos(
      name: "Galletas de Nuez",
      precio: 60.0,
      img: "https://picsum.photos/500/300",
      sabor: "Nuez",
      estado: 1,
      cantidad: 10,
      isSelected: false,
    )
  ]);

  await _verificarOCargarSubcoleccion(productosCollection, 'brownies', [
    Productos(
      name: "Brownie Clásico",
      precio: 70.0,
      img: "https://picsum.photos/500/300",
      sabor: "Chocolate",
      estado: 1,
      cantidad: 8,
      isSelected: false,
    ),
    Productos(
      name: "Brownie con Nueces",
      precio: 75.0,
      img: "https://picsum.photos/500/300",
      sabor: "Nueces",
      estado: 1,
      cantidad: 5,
      isSelected: false,
    ),
    Productos(
      name: "Brownie de Caramelo",
      precio: 80.0,
      img: "https://picsum.photos/500/300",
      sabor: "Caramelo",
      estado: 1,
      cantidad: 6,
      isSelected: false,
    ),
    Productos(
      name: "Brownie de Café",
      precio: 85.0,
      img: "https://picsum.photos/500/300",
      sabor: "Café",
      estado: 1,
      cantidad: 7,
      isSelected: false,
    ),
    Productos(
      name: "Brownie de Frambuesa",
      precio: 90.0,
      img: "https://picsum.photos/500/300",
      sabor: "Frambuesa",
      estado: 1,
      cantidad: 5,
      isSelected: false,
    )
  ]);
}

// Función para verificar y cargar productos en una subcolección
Future<void> _verificarOCargarSubcoleccion(
    CollectionReference productosCollection,
    String tipoProducto,
    List<Productos> productos) async {
  DocumentReference subcollection = productosCollection.doc(tipoProducto);
  DocumentSnapshot snapshot = await subcollection.get();

  // Verificar si el documento de la subcolección existe y si tiene 5 o más elementos
  if (snapshot.exists) {
    var data = snapshot.data() as Map<String, dynamic>;
    if (data.length >= 5) {
      print("La subcolección $tipoProducto ya tiene 5 o más productos.");
      return;
    }
  }

  for (int i = 0; i < productos.length; i++) {
    await subcollection
        .set({'$i': productos[i].toJSON()}, SetOptions(merge: true));
  }
  print("Productos añadidos a la subcolección $tipoProducto.");
}

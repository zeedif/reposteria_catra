import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:reposteria_catra/domain/models/productos.dart';
import 'package:reposteria_catra/global_controller/session_controller.dart';

class ProductosServices extends SimpleNotifier {
  FirebaseFirestore? _instance;
  final List<Productos> _pasteles = [];
  final List<Productos> _brownies = [];
  final List<Productos> _galletas = [];

  List<Productos> getPasteles() {
    return _pasteles;
  }

  List<Productos> getBrownies() {
    return _brownies;
  }

  List<Productos> getGalletas() {
    return _galletas;
  }

  List<Productos> getProductosSeleccionados() {
    List<Productos> seleccionados = [];
    for (var element in _pasteles + _brownies + _galletas) {
      if (element.isSelected == true) {
        seleccionados.add(element);
      }
    }
    return seleccionados;
  }

  Future<void> getPastelesCollectionFromFirestore() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference pasteles = _instance!.collection('productos');
    DocumentSnapshot snapshot = await pasteles.doc('pasteles').get();
    var data = snapshot.data() as Map;
    data.forEach((key, value) {
      _pasteles.add(Productos.fromJSON(value));
    });
    notify();
  }

  Future<void> getGalletasCollectionFromFirestore() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference galletas = _instance!.collection('productos');
    DocumentSnapshot snapshot = await galletas.doc('galletas').get();
    var data = snapshot.data() as Map;
    data.forEach((key, value) {
      _galletas.add(Productos.fromJSON(value));
    });
    notify();
  }

  Future<void> getBrowniesCollectionFromFirestore() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference brownies = _instance!.collection('productos');
    DocumentSnapshot snapshot = await brownies.doc('brownies').get();
    var data = snapshot.data() as Map;
    data.forEach((key, value) {
      _brownies.add(Productos.fromJSON(value));
    });
    notify();
  }

  void resetProductosToDefaults() {
    _pasteles.clear();
    _galletas.clear();
    _brownies.clear();
  }

  void seleccionarProductos(Productos producto) {
    if (producto.isSelected) {
      producto.isSelected = false;
      producto.cantidad = 1;
    } else {
      producto.isSelected = true;
    }

    notify();
  }

  void addProducto(Productos producto) {
    if (producto.cantidad < 99) {
      producto.cantidad = producto.cantidad + 1;
      notify();
    }
  }

  void removeProducto(Productos producto) {
    if (producto.cantidad > 1) {
      producto.cantidad = producto.cantidad - 1;
      notify();
    }
  }
  void guardarPedido(Map<String,dynamic> form) async {
    List<Productos> p = getProductosSeleccionados();
    _instance = FirebaseFirestore.instance;
    CollectionReference pedidos = _instance!.collection('pedidos');
    DocumentReference pedido = pedidos.doc();
    
    await pedido.set({
      'productos': p.map((e) => e.toJSON()).toList(),
      'fecha': DateTime.now(),
      'usuario': sessionProvider.read.user?.uid,
      'estado': 1,
      'nombres': form['nombres'],
      'apellidos': form['apellidos'],
      'calle': form['calle'],
      'numero_ext': form['numero_ext'],
      'colonia': form['colonia'],
      'numero_int': form['numero_int'],
      'cp': form['cp'],
      'telefono': form['telefono'],
      'correo': form['correo'],
      'metodo': form['metodo'],
    });
    for (var element in p) {
      element.isSelected = false;
      element.cantidad = 1;
    }
    notify();
  }
}

final productosProvider = SimpleProvider(
  (_) => ProductosServices(),
  autoDispose: false,
);

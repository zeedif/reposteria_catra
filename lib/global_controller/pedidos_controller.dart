import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:reposteria_catra/domain/models/pedidos.dart';
import 'package:reposteria_catra/global_controller/session_controller.dart';

class PedidosServices extends SimpleNotifier {
  FirebaseFirestore? _instance;
  final List<Pedidos> _pedidos = [];

  List<Pedidos> getPedidos() {
    return _pedidos;
  }

  PedidosServices() {
    _instance = FirebaseFirestore.instance;
    getPedidosCollectionFromFirestore();
  }

  Future<void> getPedidosCollectionFromFirestore() async {
    _instance!
        .collection('pedidos')
        .where('usuario', isEqualTo: sessionProvider.read.user?.uid)
        .snapshots()
        .listen((event) {
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            _pedidos.add(Pedidos.fromJSON(change.doc.data()!));
            notify();
            break;
          case DocumentChangeType.modified:
            break;
          case DocumentChangeType.removed:
            break;
        }
      }
    });
  }
}

final pedidosProvider = SimpleProvider(
  (_) => PedidosServices(),
  autoDispose: true,
);

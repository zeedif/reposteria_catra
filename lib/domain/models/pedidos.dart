import 'package:reposteria_catra/domain/models/productos.dart';

class Pedidos {
  String nombres, apellidos, calle, colonia, telefono, correo, metodo, user;
  List<Productos> productos;
  int estado, numeroExt, numeroInt, cp;
  DateTime fecha;
  Pedidos(
      {required this.user,
      required this.nombres,
      required this.apellidos,
      required this.calle,
      required this.numeroExt,
      required this.colonia,
      required this.numeroInt,
      required this.cp,
      required this.telefono,
      required this.correo,
      required this.metodo,
      required this.productos,
      required this.estado,
      required this.fecha});
  factory Pedidos.fromJSON(Map<String, dynamic> json) {
    return Pedidos(
      user: json['usuario'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      calle: json['calle'],
      numeroExt: json['numero_ext'].toInt(),
      colonia: json['colonia'],
      numeroInt: json['numero_int'].toInt(),
      cp: json['cp'].toInt(),
      telefono: json['telefono'],
      correo: json['correo'],
      metodo: json['metodo'],
      productos: (json['productos'] as List)
          .map((e) => Productos.fromJSON(e as Map<String, dynamic>))
          .toList(),
      estado: json['estado'].toInt(),
      fecha: json['fecha'].toDate(),
    );
  }
}

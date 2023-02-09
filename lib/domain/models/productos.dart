class Productos {
  String name;
  double precio;
  String img;
  String sabor;
  int estado;
  int cantidad;
  bool isSelected;
  Productos(
      {required this.name,
      required this.precio,
      required this.img,
      required this.sabor,
      required this.estado,
      required this.cantidad,
      required this.isSelected});
  factory Productos.fromJSON(Map<String, dynamic> json) {
    return Productos(
        name: json['nombre'],
        precio: json['precio'].toDouble(),
        img: json['img'],
        sabor: json['sabor'],
        estado: json['estado']?.toInt() ?? 0,
        cantidad: json['cantidad'] ?? 1,
        isSelected: false);
  }

  toJSON() {
    return {
      'nombre': name,
      'precio': precio,
      'img': img,
      'sabor': sabor,
      'cantidad': cantidad
    };
  }
}

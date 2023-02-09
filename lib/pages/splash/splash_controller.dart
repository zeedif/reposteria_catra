import 'package:flutter_meedu/meedu.dart';
import 'package:reposteria_catra/global_controller/productos_controller.dart';
import 'package:reposteria_catra/domain/repositories/authentication_repository.dart';
import 'package:reposteria_catra/global_controller/session_controller.dart';
import 'package:reposteria_catra/routes/routes.dart';

class SplashController extends SimpleNotifier {
  final SessionController _sessionController;
  final ProductosServices _productosServices;
  final _authRepository = Get.find<AuthenticationRepository>();
  String? _routeName;
  String? get routeName => _routeName;
  SplashController(this._sessionController, this._productosServices) {
    _init();
  }

  void _init() async {
    final user = await _authRepository.user;
    if (user != null) {
      _routeName = Rutas.HOME;
      _sessionController.setUser(user);
      _productosServices.getPastelesCollectionFromFirestore();
      _productosServices.getGalletasCollectionFromFirestore();
      _productosServices.getBrowniesCollectionFromFirestore();
    } else {
      _routeName = Rutas.LOGIN;
    }
    notify();
  }
}

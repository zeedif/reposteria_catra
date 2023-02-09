
import 'package:flutter/widgets.dart' show GlobalKey, FormState;
import 'package:flutter_meedu/meedu.dart';
import 'package:reposteria_catra/global_controller/productos_controller.dart';
import 'package:reposteria_catra/domain/repositories/authentication_repository.dart';
import 'package:reposteria_catra/global_controller/session_controller.dart';

class LoginController extends SimpleNotifier {
  final SessionController _sessionController;
  final ProductosServices _productosServices;
  String _email ='', _password = '';
  final _authenticationRepository = Get.find<AuthenticationRepository>();
  final GlobalKey<FormState> formKey = GlobalKey();

  LoginController(this._sessionController, this._productosServices);

  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<SignInResponse> submit() async{
    final response = await _authenticationRepository.signInWithEmailAndPassword(_email, _password);
    if(response.error==null){
      _sessionController.setUser(response.user!);
      _productosServices.getPastelesCollectionFromFirestore();
      _productosServices.getGalletasCollectionFromFirestore();
      _productosServices.getBrowniesCollectionFromFirestore();
    }
    return response;
  }

}

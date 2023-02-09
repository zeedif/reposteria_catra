import 'package:flutter/widgets.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:reposteria_catra/global_controller/productos_controller.dart';
import 'package:reposteria_catra/domain/repositories/signup_repository.dart';
import 'package:reposteria_catra/global_controller/session_controller.dart';
import 'package:reposteria_catra/pages/register/controller/register_state.dart';

class RegisterController extends StateNotifier<RegisterState> {
  final SessionController _sessionController;
  final ProductosServices _productosServices;
  RegisterController(this._sessionController, this._productosServices) : super(RegisterState.initialState);
  final GlobalKey<FormState> formKey = GlobalKey();
  final _signUpRepository = Get.find<SignUpRepository>();
  
  Future<SignUpResponse> submit() async {
    final response = await _signUpRepository.register(
      SignUpData(
        username: state.username,
        email: state.email,
        password: state.password,
      ),
    );
    if(response.error==null){
      _sessionController.setUser(response.user!);
      _productosServices.getPastelesCollectionFromFirestore();
      _productosServices.getGalletasCollectionFromFirestore();
      _productosServices.getBrowniesCollectionFromFirestore();
    }
    return response;
  }

  void onUsernameChanged(String text) {
    state = state.copyWith(username: text);
  }

  void onEmailChanged(String text) {
    state = state.copyWith(email: text);
  }

  void onPasswordChanged(String text) {
    state = state.copyWith(password: text);
  }

  void onVPasswordChanged(String text) {
    state = state.copyWith(vPassword: text);
  }
}

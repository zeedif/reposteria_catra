import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';

class HomeController extends SimpleNotifier {
  PageController scrollControl = PageController(initialPage: 1);
  int currentPage = 1;
  void cambiarPantalla(int i) {
    if (i == currentPage){
      currentPage = 1;
    } else {
      currentPage = i;
    }
    scrollControl.animateToPage(currentPage,
        duration: const Duration(milliseconds: 350), curve: Curves.linear);
    notifyListeners;
  }
}

final homeProvider = SimpleProvider(
  (_) => HomeController(),
);

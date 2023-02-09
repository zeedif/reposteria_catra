import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reposteria_catra/inject_dependencies.dart';
import 'package:reposteria_catra/routes/app_routes.dart';
import 'package:reposteria_catra/routes/routes.dart';
import 'package:flutter_meedu/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  injectDependencies();
  runApp(const MyApp());
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Respostería Catra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        scaffoldBackgroundColor: const Color.fromARGB(255, 186, 104, 200),
        primarySwatch: Colors.purple,
      ),
      navigatorKey: router.navigatorKey,
      navigatorObservers: [
        router.observer,
      ],
      initialRoute: Rutas.SPLASH,
      routes: appRutas,
    );
  }
}

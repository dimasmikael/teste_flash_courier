import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_flash_courier/splash_screen.dart';
import 'package:teste_flash_courier/views/home/home_view.dart';




void main() async {
  runApp(Container(
    color: Colors.red,

    child: const CircularProgressIndicator(),
  ));

  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/': (context) => const SplashScreen(),
        '/homeview': (context) => const HomeView(),
      },
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

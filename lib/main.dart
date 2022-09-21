import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teste_flash_courier/splash_screen.dart';
import 'package:teste_flash_courier/views/home/home_view.dart';
import 'package:teste_flash_courier/views/login/login_view.dart';
import 'package:teste_flash_courier/views/registration/address_registration_view.dart';

void main() async {
  runApp(
    Container(
      color: const Color(0xff6A8EC8),
    ),
  );

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/': (context) => const SplashScreen(),
        '/homeview': (context) => const HomeView(),
        '/loginview': (context) => const LoginView(),
        '/Addressregistrationview': (context) =>
            const AddressRegistrationView(),
      },
    );
  }
}

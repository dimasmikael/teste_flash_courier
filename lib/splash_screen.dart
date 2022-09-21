import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:teste_flash_courier/views/home/home_view.dart';
import 'package:teste_flash_courier/views/login/login_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? loggedUser;
  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    loggedUser = auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/logo.png'),
      nextScreen: loggedUser == null ? const LoginView() : const HomeView(),
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      backgroundColor: const Color(0xff3F5398),
      duration: 5000,
      splashIconSize: 300,
    );
  }
}

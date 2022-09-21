import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste_flash_courier/models/usuario_model.dart';

class UserRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  registerUser(UserModel? user, BuildContext? context) {
   // FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
            email: user!.email, password: user.password)
        .then(
      (firebaseUser) {
        Navigator.pushReplacementNamed(context!, '/homeview');
      },
    );
    return null;
  }

  loginUser(UserModel? user, BuildContext? context) {
   // FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(email: user!.email, password: user.password)
        .then(
      (firebaseUser) {
        Navigator.pushReplacementNamed(context!, '/homeview');
      },
    );
  }

  logoutUser(BuildContext context, [bool mounted = true]) async {
   // FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    if (!mounted) return;
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/loginview', (Route<dynamic> route) => false);

      //   await Navigator.restorablePushReplacementNamed(context, "/login");
     }
}

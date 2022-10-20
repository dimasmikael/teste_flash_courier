import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste_flash_courier/models/usuario_model.dart';
import 'package:teste_flash_courier/shared/alerts/alert.dart';

class UserRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  Alert alert = Alert();
  registerUser(UserModel? user, BuildContext? context) async {
    try {
      auth
          .createUserWithEmailAndPassword(
              email: user!.email, password: user.password)
          .then(
        (firebaseUser) {
          Navigator.pushReplacementNamed(context!, '/homeview');
        },
      );
    } on FirebaseAuthException catch (error) {
      print(error);
      alert.error(
        context!,
        error.toString(),
      );
    } catch (e) {
      print(e);
      alert.error(
        context!,
        e.toString(),
      );
    }
  }

  loginUser(UserModel? user, BuildContext? context) async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: user!.email, password: user.password)
          .then(
        (firebaseUser) {
          Navigator.pushReplacementNamed(context!, '/homeview');
        },
      );

      alert.success(context!, 'Sucesso!');
    } on FirebaseAuthException catch (error) {
      print(error);
      alert.error(
        context!,
        error.toString(),
      );
    } catch (e) {
      print(e);
      alert.error(
        context!,
        e.toString(),
      );
    }
  }

  logoutUser(BuildContext context, [bool mounted = true]) async {
    try {
      await auth.signOut().then(
        (firebaseUser) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/loginview', (Route<dynamic> route) => false);
        },
      );
      if (!mounted) return;
      alert.success(context, 'Deslogado com sucesso');
    } on FirebaseAuthException catch (error) {
      print(error);
      alert.error(
        context,
        error.toString(),
      );
    } catch (e) {
      print(e);
      alert.error(
        context,
        e.toString(),
      );
    }
  }
}

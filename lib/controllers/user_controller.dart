import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste_flash_courier/models/usuario_model.dart';
import 'package:teste_flash_courier/repositories/user_repository.dart';

class UserController {
  UserRepository repository = UserRepository();

  getRegisterUser(UserModel user, BuildContext? context) {
    try {
      repository.registerUser(user, context);

      print("4545454");
    } catch (e, s) {
      print(e);
      print(1);
      print(2);
    }

    //   return null;
  }

  getLoginUser(UserModel user, BuildContext? context) {
    try {
      repository.loginUser(user, context);

      print("656565");
    } catch (e, s) {
      print(e);
      print(1);
      print(2);
    }

    //   return null;
  }

  getLogoutUser(BuildContext context) {
    try {
      repository.logoutUser(context);

      print("656565");
    } catch (e, s) {
      print(e);
      print(1);
      print(2);
    }

    //   return null;
  }
}

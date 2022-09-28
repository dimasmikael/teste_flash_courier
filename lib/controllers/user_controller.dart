import 'package:flutter/material.dart';
import 'package:teste_flash_courier/models/usuario_model.dart';
import 'package:teste_flash_courier/repositories/user_repository.dart';
import 'package:teste_flash_courier/shared/alerts/alert.dart';

class UserController {
  UserRepository repository = UserRepository();

  Alert alert = Alert();

  getRegisterUser(UserModel user, BuildContext? context) async {
    await repository.registerUser(user, context);
  }

  getLoginUser(UserModel user, BuildContext? context) async {
    await repository.loginUser(user, context);
  }

  getLogoutUser(BuildContext context) async {
    await repository.logoutUser(context);
  }

}

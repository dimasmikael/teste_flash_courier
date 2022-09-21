import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:teste_flash_courier/models/usuario_model.dart';
import 'package:teste_flash_courier/repositories/user_repository.dart';
import 'package:teste_flash_courier/shared/alerts/alert.dart';

class UserController {
  UserRepository repository = UserRepository();

  Alert alert = Alert();

  getRegisterUser(UserModel user, BuildContext? context) {
    try {
      repository.registerUser(user, context);
      alert.success(context!, 'Login cadastrado com sucesso');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      alert.error(context!, 'Erro na tentativa de cadastro de  login');
    }
  }

  getLoginUser(UserModel user, BuildContext? context) {
    try {
      repository.loginUser(user, context);
      alert.success(context!, 'Sucesso!');
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
      }
      alert.error(context!, 'Erro na tentativa  de  login');
    }
    ;
  }

  getLogoutUser(BuildContext context) {
    try {
      repository.logoutUser(context);
      alert.success(context, 'Deslogado com sucesso');
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
      }
      alert.error(context, 'Erro na tentativa  de  deslogar');
    }
  }
}

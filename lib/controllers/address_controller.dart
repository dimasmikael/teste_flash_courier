import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste_flash_courier/models/usuario_model.dart';
import 'package:teste_flash_courier/repositories/address_repository.dart';
import 'package:teste_flash_courier/repositories/user_repository.dart';

class AddressController {
  AddressRepository repository = AddressRepository();

  getRemoveAddress(String idAddress, String idUsuarioLogado) {
    try {
      repository.removeAddress(idAddress, idUsuarioLogado);

      print("4545454");
    } catch (e, s) {
      print(e);
      print(1);
      print(2);
    }

    //   return null;
  }
}

import 'package:flutter/material.dart';
import 'package:teste_flash_courier/repositories/address_repository.dart';
import 'package:teste_flash_courier/shared/alerts/alert.dart';

class AddressController {
  AddressRepository repository = AddressRepository();
  Alert alert = Alert();

  getRemoveAddress(
      String idAddress, String idUserLogged, BuildContext context) {
    try {
      repository.removeAddress(idAddress, idUserLogged);
      alert.success(context, 'Endereço removido  com sucesso');
    } catch (e, s) {
      alert.error(context, 'Erro na tentativa  de  remover endereço');
    }
  }
}

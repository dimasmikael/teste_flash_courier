import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teste_flash_courier/models/address_model.dart';
import 'package:teste_flash_courier/repositories/address_repository.dart';
import 'package:teste_flash_courier/shared/alerts/alert.dart';

class AddressController extends ChangeNotifier {
  AddressRepository repository = AddressRepository();
  Alert alert = Alert();
  final controllerStream = StreamController<QuerySnapshot>.broadcast();

  getRemoveAddress(
      String idAddress, String idUserLogged, BuildContext context) {
    try {
      repository.removeAddress(idAddress, idUserLogged);
      alert.success(context, 'Endereço removido  com sucesso');
    } catch (e, s) {
      print(e);
      alert.error(context, 'Erro na tentativa  de  remover endereço');
    }
    notifyListeners();
  }

  getLoadAddress(String idUserLogged, controllerStream, BuildContext context) {
    try {
      repository.loadAddress(idUserLogged, controllerStream);
      alert.success(context, 'Endereço(s) carregados com sucesso');
    } catch (e, s) {
      print(e);
      alert.error(context, 'Erro na tentativa  de  carregar os endereços');
    }
    notifyListeners();
  }

  getSaveAddress(String id, AddressModel? address, BuildContext context) {
    try {
      repository.saveAddress(id, address!, context);
      alert.success(context, 'Endereço salvo com sucesso');
    } catch (e, s) {
      print(e);
      alert.error(context, 'Erro na tentativa  de  salvar o endereço');
    }
    notifyListeners();
  }

  getupdateAddress(String id, AddressModel address, BuildContext context) {
    try {
      repository.updateAddress(id, address, context);
      alert.success(context, 'Endereço atualizadocom sucesso');
    } catch (e, s) {
      print(e);
      alert.error(context, 'Erro na tentativa  de  atualizar o endereço');
    }
    notifyListeners();
  }
}

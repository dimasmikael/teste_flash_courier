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
      String idAddress, String idUserLogged, BuildContext context) async {
    await repository.removeAddress(idAddress, idUserLogged, context);
    notifyListeners();
  }

  getLoadAddress(
      String idUserLogged, controllerStream, BuildContext context) async {
    await repository.loadAddress(idUserLogged, controllerStream, context);
    notifyListeners();
  }

  getSaveAddress(String id, AddressModel? address, BuildContext context) async {
    await repository.saveAddress(id, address!, context);
    notifyListeners();
  }

  getupdateAddress(
      String id, AddressModel address, BuildContext context) async {
    await repository.updateAddress(id, address, context);
    notifyListeners();
  }
}

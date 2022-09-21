import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste_flash_courier/repositories/user_repository.dart';

class AddressRepository {
  var db = FirebaseFirestore.instance;

  removeAddress(String idAddress, String idUsuarioLogado) {
    var db = FirebaseFirestore.instance;
    db
        .collection("my-addresses")
        .doc(idUsuarioLogado)
        .collection("addresses")
        .doc(idAddress)
        .delete();
  }
}

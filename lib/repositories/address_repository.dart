import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teste_flash_courier/models/address_model.dart';
import 'package:flutter/material.dart';

class AddressRepository {
  var db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  removeAddress(String idAddress, String idUserLogged) {
    db
        .collection("my-addresses")
        .doc(idUserLogged)
        .collection("addresses")
        .doc(idAddress)
        .delete();
  }

  Future<Stream<QuerySnapshot>?>? loadAddress(
      String idUserLogged, controllerStream) async {
    var db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("my-addresses")
        .doc(idUserLogged)
        .collection("addresses")
        .snapshots();

    stream.listen(
      (data) {
        controllerStream.add(data);
      },
    );
  }

  saveAddress(String id, AddressModel address, BuildContext context) {
    User? loggedUser = auth.currentUser!;
    String? idUserLogged = loggedUser.uid;

    db
        .collection("my-addresses")
        .doc(idUserLogged)
        .collection("addresses")
        .doc(id)
        .set(address.toMap())
        .then(
      (_) {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  updateAddress(String id, AddressModel address, BuildContext context) {
    User? loggedUser = auth.currentUser!;
    String? idUserLogged = loggedUser.uid;

    db
        .collection("my-addresses")
        .doc(idUserLogged)
        .collection("addresses")
        .doc(id)
        .update(address.toMap())
        .then(
      (_) {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }
}

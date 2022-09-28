import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teste_flash_courier/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:teste_flash_courier/shared/alerts/alert.dart';

class AddressRepository {
  var db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Alert alert = Alert();

  removeAddress(String idAddress, String idUserLogged, BuildContext context) {
    try {
      db
          .collection("my-addresses")
          .doc(idUserLogged)
          .collection("addresses")
          .doc(idAddress)
          .delete();
      alert.success(context, 'Endereço removido  com sucesso');
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

  Future<Stream<QuerySnapshot>?>? loadAddress(
      String idUserLogged, controllerStream, BuildContext context) async {
    try {
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
      alert.success(context, 'Endereço(s) carregados com sucesso');
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

  saveAddress(String id, AddressModel address, BuildContext context) {
    try {
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
      alert.success(context, 'Endereço salvo com sucesso');
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

  updateAddress(String id, AddressModel address, BuildContext context) {
    try {
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

      alert.success(context, 'Endereço atualizado com sucesso');
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
}

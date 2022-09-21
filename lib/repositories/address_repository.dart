import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teste_flash_courier/repositories/user_repository.dart';

class AddressRepository {
  UserRepository repositoryUser = UserRepository();
  final controller = StreamController<QuerySnapshot>.broadcast();
  var db = FirebaseFirestore.instance;

  Future<Stream<QuerySnapshot>?>? loadAddresses(
      String idUsuarioLogado, controller) async {
    try {
      print("Sim");
      await repositoryUser.retrieveloggedUserData(idUsuarioLogado);

      Stream<QuerySnapshot> stream = db
          .collection("my-addresses")
          .doc(idUsuarioLogado)
          .collection("addresses")
          .snapshots();

      stream.listen((data) {
        controller.add(data);
      });
    } catch (e) {
      print("Naõo");
    }
    return null;
  }
  // registerUser(UserModel? user, BuildContext? context) {
  //   // FirebaseAuth auth = FirebaseAuth.instance;
  //
  //   auth
  //       .createUserWithEmailAndPassword(
  //       email: user!.email, password: user.password)
  //       .then(
  //         (firebaseUser) {
  //       Navigator.pushReplacementNamed(context!, '/homeview');
  //     },
  //   );
  //   return null;
  // }
  //
  // loginUser(UserModel? user, BuildContext? context) {
  //   // FirebaseAuth auth = FirebaseAuth.instance;
  //
  //   auth
  //       .signInWithEmailAndPassword(email: user!.email, password: user.password)
  //       .then(
  //         (firebaseUser) {
  //       Navigator.pushReplacementNamed(context!, '/homeview');
  //     },
  //   );
  // }
  //
  // logoutUser(BuildContext context, [bool mounted = true]) async {
  //   // FirebaseAuth auth = FirebaseAuth.instance;
  //   await auth.signOut();
  //   if (!mounted) return;
  //   Navigator.of(context)
  //       .pushNamedAndRemoveUntil('/loginview', (Route<dynamic> route) => false);
  //
  //   //   await Navigator.restorablePushReplacementNamed(context, "/login");
  // }
  //
  // _recuperaDadosUsuarioLogado() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User usuarioLogado = auth.currentUser!;
  //   _idUsuarioLogado = usuarioLogado.uid;
  // }
}

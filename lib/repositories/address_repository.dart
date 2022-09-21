import 'package:cloud_firestore/cloud_firestore.dart';

class AddressRepository {
  var db = FirebaseFirestore.instance;

  removeAddress(String idAddress, String idUserLogged) {
    var db = FirebaseFirestore.instance;
    db
        .collection("my-addresses")
        .doc(idUserLogged)
        .collection("idUserLogged")
        .doc(idAddress)
        .delete();
  }
}

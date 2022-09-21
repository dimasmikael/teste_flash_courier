import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String _id = '';
  String _country = '';
  String _street = '';
  String _district = '';
  String _state = '';
  int _number = 0;
  int _zipCode = 0;

  List<String> _photoCountry = [];
  AddressModel();

  AddressModel.generateId() {
    var db = FirebaseFirestore.instance;
    CollectionReference adresses = db.collection("my-addresses");
    id = adresses.doc().id;

    photoCountry = [];
  }

  List<String> get photoCountry => _photoCountry;

  set photoCountry(List<String> value) {
    _photoCountry = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String get street => _street;

  set street(String value) {
    _street = value;
  }

  String get district => _district;

  set district(String value) {
    _district = value;
  }

  String get state => _state;

  set state(String value) {
    _state = value;
  }

  int get number => _number;

  set number(int value) {
    _number = value;
  }

  int get zipCode => _zipCode;

  set zipCode(int value) {
    _zipCode = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  AddressModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
  country = doc['country'] ?? '';
    street = doc['street'] ?? '';
    district = doc['district'] ?? '';
    state = doc['state'] ?? '';
   number = (doc['number'])?? 0;
    zipCode = doc['zipCode']?? 0;
    photoCountry = List<String>.from(doc['photoCountry'] ?? []);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "country": country, "street": street,
      "district": district,
      "state": state,
       "number": number,
      "zipCode": zipCode,
      "photoCountry": photoCountry,
    };

    return map;
  }
}

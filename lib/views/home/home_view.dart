import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:teste_flash_courier/controllers/address_controller.dart';
import 'package:teste_flash_courier/models/address_model.dart';
import 'package:teste_flash_courier/shared/appbar/custom_appbar.dart';
import 'package:teste_flash_courier/shared/drawer/app-drawer/app-drawer.dart';
import 'package:teste_flash_courier/shared/style/text/style_text.dart';
import 'package:teste_flash_courier/views/details/details_view.dart';
import 'package:teste_flash_courier/views/home/home_view_widgets/home_view_item_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controllerStream = StreamController<QuerySnapshot>.broadcast();
  String? _idUserLogged;
  AddressController? controller = AddressController();
  AddressModel? _address;

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  _retrieveUserDataLogged() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = auth.currentUser!;
    _idUserLogged = usuarioLogado.uid;
  }

  Future<Stream<QuerySnapshot>?>? _loadAddress() async {
    await _retrieveUserDataLogged();

    var db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("my-addresses")
        .doc(_idUserLogged)
        .collection("addresses")
        .snapshots();

    stream.listen((data) {
      _controllerStream.add(data);
    });
  }

  final _loadingDataWigget = Center(
    child: Column(
      children: const <Widget>[
        Text("Carregando endereços"),
        CircularProgressIndicator(
          color: Colors.orangeAccent,
        )
      ],
    ),
  );

  Future? _showRemovalDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Confirmar"),
            content: const Text("Deseja realmente excluir o endereço?"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                //  color: Colors.red,
                child: const Text(
                  "Remover",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  controller!.getRemoveAddress(_address!.id, _idUserLogged!);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text:'Flash Courier APP'),
      drawer: AppDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controllerStream.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return _loadingDataWigget;

            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) return const Text("Error loading data!");

              QuerySnapshot? querySnapshot = snapshot.data;

              return ListView.builder(
                  itemCount: querySnapshot!.docs.length,
                  itemBuilder: (_, indice) {
                    List<DocumentSnapshot>? adresses =
                        querySnapshot.docs.toList();
                    DocumentSnapshot documentSnapshot = adresses[indice];
                  AddressModel  address =
                        AddressModel.fromDocumentSnapshot(documentSnapshot);

                    return HomeViewItemWidget(
                      onTapItem:()=>

                       //   SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => DetailsView(address,))),
                        //  },//),

                      address: address,
                      onPressedRemover: () {
                        _showRemovalDialog();
                      },
                    );
                  });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        onPressed: () =>
            Navigator.pushNamed(context, '/Addressregistrationview'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste_flash_courier/models/address_model.dart';
import 'package:teste_flash_courier/repositories/address_repository.dart';
import 'package:teste_flash_courier/shared/drawer/app-drawer/app-drawer.dart';
import 'package:teste_flash_courier/views/home/home_view_widgets/home_view_item_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
String? _idUsuarioLogado;
  AddressRepository? repository = AddressRepository();
  AddressModel? address;


  _recuperaDadosUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = auth.currentUser!;
    _idUsuarioLogado = usuarioLogado.uid;
  }
  Future<Stream<QuerySnapshot>?>? _adicionarListenerAnuncios() async {
    await _recuperaDadosUsuarioLogado();

    var db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("my-addresses")
        .doc(_idUsuarioLogado)
        .collection("addresses")
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  @override
  void initState() {
    super.initState();
    _adicionarListenerAnuncios();
  // repository?.loadAddresses(_idUsuarioLogado??'', _controller);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flash Courier APP'),
      ),
      drawer: AppDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return _loadingDataWigget;

            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) return const Text("Error loading data!");

              QuerySnapshot? querySnapshot = snapshot.data;
              //DocumentSnapshot? snap = snapshot.data;

              //DocumentSnapshot querySnapshot = snapshot.data as DocumentSnapshot;

              return ListView.builder(
                  itemCount: querySnapshot!.docs.length,
                  itemBuilder: (_, indice) {
                    List<DocumentSnapshot>? adresses =
                        querySnapshot.docs.toList();
                    DocumentSnapshot documentSnapshot = adresses[indice];
                    address=
                        AddressModel.fromDocumentSnapshot(documentSnapshot);

                    return HomeViewItemWidget(
                      address: address,
                      onPressedRemover: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Confirmar"),
                                content: const Text(
                                    "Deseja realmente excluir o anúncio?"),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text(
                                      "Cancelar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    //  color: Colors.red,
                                    child: const Text(
                                      "Remover",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    onPressed: () {
                                      //    _removerAnuncio(exercicio?.id ?? '');
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                    );
                  });
          }
        },
      ),
        floatingActionButton: FloatingActionButton(
            backgroundColor:  Colors.orangeAccent,
            foregroundColor: Colors.white,
            onPressed: () =>


        Navigator.pushNamed(context, '/Addressregistrationview', arguments: address),
            child: const Icon(Icons.add),
              )
    );
  }
}

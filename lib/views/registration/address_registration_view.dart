import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teste_flash_courier/models/address_model.dart';
import 'package:teste_flash_courier/repositories/address_repository.dart';
import 'package:teste_flash_courier/repositories/user_repository.dart';
import 'package:teste_flash_courier/views/registration/address_registration_view_widgets/registration_view_custom_button.dart';
import 'package:teste_flash_courier/views/registration/address_registration_view_widgets/registration_view_custom_input.dart';

class AddressRegistrationView extends StatefulWidget {
  const AddressRegistrationView({Key? key}) : super(key: key);

  @override
  State<AddressRegistrationView> createState() =>
      _AddressRegistrationViewState();
}

class _AddressRegistrationViewState extends State<AddressRegistrationView> {
  AddressModel? _address;
  // late  BuildContext _dialogContext;




  @override
  void initState() {
    super.initState();

    _address = AddressModel.generateId();
  }

  final List<XFile> _listImages = [];

  final _formKey = GlobalKey<FormState>();
  //

  _selectImageGallery() async {
    final ImagePicker _picker = ImagePicker();
    XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      setState(() {
        _listImages.add(selectedImage);
      });
    }
  }

  _openDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text("Salvando endereço...")
              ],
            ),
          );
        });
  }

  _saveAddress() async {
    _openDialog(context);

    //Upload imagens no Storage
    await _uploadImagens();

  //  print("lista imagens: ${_aluno?.fotos.toString()}");

    //Salvar anuncio no Firestore
    //Salvar anuncio no Firestore


    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = auth.currentUser!;
    String? idUsuarioLogado = usuarioLogado?.uid;


    var db = FirebaseFirestore.instance;
    db
        .collection("my-addresses")
        .doc(idUsuarioLogado)
        .collection("addresses")
        .doc(_address!.id)
        .set(_address!.toMap())
        .then((_) {
      // Navigator.pop(context);

      Navigator.pop(context);
      Navigator.pop(context);
      //Navigator.restorablePushReplacementNamed(context,"/home");
    });
  }

  Future _uploadImagens() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();

    for (var image in _listImages) {
      String nomeImage = DateTime.now().millisecondsSinceEpoch.toString();
      Reference arquivo =
          pastaRaiz.child("my-addresses").child(_address!.id).child(nomeImage);

      UploadTask uploadTask = arquivo.putFile(File(image.path));
      TaskSnapshot taskSnapshot = await uploadTask;

      String url = await taskSnapshot.ref.getDownloadURL();
      _address?.photoCountry!.add(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo endereço"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FormField<List>(
                    initialValue: _listImages,
                    validator: (images) {
                      if (images!.isEmpty) {
                        return "Necessário selecionar uma imagem!";
                      }
                      return null;
                    },
                    builder: (state) {
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _listImages.length + 1, //3
                                itemBuilder: (context, indice) {
                                  if (indice == _listImages.length) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          _selectImageGallery();
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey[400],
                                          radius: 50,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.add_a_photo,
                                                size: 40,
                                                color: Colors.grey[100],
                                              ),
                                              Text(
                                                "Adicionar",
                                                style: TextStyle(
                                                    color: Colors.grey[100]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  if (_listImages.isNotEmpty) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Image.file(
                                                          File(
                                                            _listImages![
                                                                    indice]
                                                                .path,
                                                          ),
                                                          cacheHeight: 700,
                                                          cacheWidth: 700,
                                                          fit: BoxFit.contain,
                                                        ),
                                                        FlatButton(
                                                          textColor: Colors.red,
                                                          onPressed: () {
                                                            setState(() {
                                                              _listImages
                                                                  .removeAt(
                                                                      indice);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            });
                                                          },
                                                          child:
                                                              const Text("Excluir"),
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                        },
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: FileImage(
                                              File(_listImages[indice].path)),
                                          child: Container(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.4),
                                            alignment: Alignment.center,
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                }),
                          ),
                          if (state.hasError)
                            Text(
                              "[${state.errorText}]",
                              style:
                                  const TextStyle(color: Colors.red, fontSize: 14),
                            )
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15, top: 15),
                    child: CustomInputWidget(
                      onSaved: (String? estado) {
                        _address?.state= estado!;
                      },
                      hint: "Aluno - Nome",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'campo obrigatório';
                        }
                        return null;
                      },
                    ),
                  ),
                  CustomButtonWidget(
                    text: "Cadastrar endereço",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //salva campos
                        _formKey.currentState!.save();

                        //salvar anuncio
                        _saveAddress();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

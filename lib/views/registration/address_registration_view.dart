import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teste_flash_courier/controllers/address_controller.dart';
import 'package:teste_flash_courier/models/address_model.dart';
import 'package:teste_flash_courier/shared/appbar/custom_appbar.dart';
import 'package:teste_flash_courier/views/registration/address_registration_view_widgets/button_widget/registration_view_custom_button.dart';
import 'package:teste_flash_courier/views/registration/address_registration_view_widgets/form_widget/registration_view_form_widget.dart';
import 'package:teste_flash_courier/views/registration/address_registration_view_widgets/form_widget/registration_view_photo_widget.dart';

class AddressRegistrationView extends StatefulWidget {
  const AddressRegistrationView({Key? key}) : super(key: key);

  @override
  State<AddressRegistrationView> createState() =>
      _AddressRegistrationViewState();
}

class _AddressRegistrationViewState extends State<AddressRegistrationView> {
  AddressModel? _address;
  AddressController controller = AddressController();

  @override
  void initState() {
    super.initState();

    _address = AddressModel.generateId();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final List<XFile> _listImages = [];
  List<XFile>? _imageFileList;

  final _formKey = GlobalKey<FormState>();

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

    await _uploadImages();

    if (mounted) {
      controller.getSaveAddress(_address!.id, _address!, context);
    }
  }

  Future _uploadImages() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();

    for (var image in _listImages) {
      String nomeImage = DateTime.now().millisecondsSinceEpoch.toString();
      Reference arquivo =
          pastaRaiz.child("my-addresses").child(_address!.id).child(nomeImage);

      UploadTask uploadTask = arquivo.putFile(File(image.path));
      TaskSnapshot taskSnapshot = await uploadTask;

      String url = await taskSnapshot.ref.getDownloadURL();
      _address?.photoCountry.add(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'Novo endereço'),
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
                  PhotoWidget(
                      listImages: _listImages, imageFileList: _imageFileList),
                  FormWidget(address: _address),
                  CustomButtonWidget(
                    text: "Cadastrar endereço",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

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

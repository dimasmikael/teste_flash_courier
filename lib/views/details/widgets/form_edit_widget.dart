import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_flash_courier/controllers/address_controller.dart';
import 'package:teste_flash_courier/models/address_model.dart';
import 'package:teste_flash_courier/shared/appbar/custom_appbar.dart';
import 'package:teste_flash_courier/shared/config/size-config/size-config.dart';
import 'package:teste_flash_courier/views/registration/address_registration_view_widgets/button_widget/registration_view_custom_button.dart';
import 'package:teste_flash_courier/views/registration/address_registration_view_widgets/form_widget/custom_input_widget/registration_view_custom_input.dart';

class FormEditWidget extends StatefulWidget {
  const FormEditWidget({Key? key, this.address}) : super(key: key);
  final AddressModel? address;
  @override
  State<FormEditWidget> createState() => _FormEditWidgetState();
}

class _FormEditWidgetState extends State<FormEditWidget> {
  final TextEditingController? controllerCountry = TextEditingController();
  final TextEditingController? controllerState = TextEditingController();
  final TextEditingController? controllerCity = TextEditingController();
  final TextEditingController? controllerDistrict = TextEditingController();
  final TextEditingController? controllerZipCode = TextEditingController();
  final TextEditingController? controllerNumber = TextEditingController();
  final TextEditingController? controllerPublicPlace = TextEditingController();

  AddressController controller = AddressController();

  @override
  void initState() {
    super.initState();
    _startForm();
  }

  @override
  void dispose() {
    super.dispose();
    controllerCountry!.dispose();
    controllerState!.dispose();
    controllerCity!.dispose();
    controllerDistrict!.dispose();
    controllerZipCode!.dispose();
    controllerNumber!.dispose();
    controllerPublicPlace!.dispose();
  }

  Future<void> _startForm() async {
    setState(() {
      controllerCountry!.text = widget.address?.country ?? '';
      controllerState!.text = widget.address?.state ?? '';
      controllerCity!.text = widget.address?.city ?? '';
      controllerDistrict!.text = widget.address?.district ?? '';
      controllerZipCode!.text = widget.address?.zipCode.toString() ?? '';
      controllerNumber!.text = widget.address?.number.toString() ?? '';
      controllerPublicPlace!.text = widget.address?.publicPlace ?? '';
    });
  }

  _updateAddress() async {
    _openDialog(context);

    await _setAddress();

    if (mounted) {
      controller.getSaveAddress(widget.address!.id, widget.address, context);
    }
  }

  _setAddress() async {
    setState(() {
      widget.address?.country = controllerCountry!.text;
      widget.address?.state = controllerState!.text;
      widget.address?.city = controllerCity!.text;
      widget.address?.district = controllerDistrict!.text;
      widget.address?.zipCode = int.parse(
          controllerZipCode!.text.replaceAll('.', '').replaceAll('-', ''));
      widget.address?.number = int.parse(controllerNumber!.text);
      widget.address?.publicPlace = controllerPublicPlace!.text;
    });
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
              Text("Atualizando endereço...")
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: const CustomAppBar(text: 'Editar endereço'),
      body: SizedBox(
        height: SizeConfig.screenHeight! * 100,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomInputWidget(
                          controller: controllerCountry,
                          type: TextInputType.text,
                          hint: "País",
                        ),
                      ),
                      Expanded(
                        child: CustomInputWidget(
                          controller: controllerState,
                          type: TextInputType.text,
                          hint: "Estado",
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomInputWidget(
                          controller: controllerCity,
                          type: TextInputType.text,
                          hint: "Cidade",
                        ),
                      ),
                      Expanded(
                        child: CustomInputWidget(
                          controller: controllerDistrict,
                          type: TextInputType.text,
                          hint: "Bairro",
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomInputWidget(
                          controller: controllerZipCode,
                          type: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter(),
                          ],
                          hint: "CEP",
                        ),
                      ),
                      Expanded(
                        child: CustomInputWidget(
                          controller: controllerNumber,
                          type: TextInputType.number,
                          hint: "Número",
                        ),
                      )
                    ],
                  ),
                  CustomInputWidget(
                    controller: controllerPublicPlace,
                    type: TextInputType.text,
                    hint: "Logradouro",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButtonWidget(
                      text: "Atualizar",
                      onPressed: () async {
                        await _updateAddress();
                      },
                    ),
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

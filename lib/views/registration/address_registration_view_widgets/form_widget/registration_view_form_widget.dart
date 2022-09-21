import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_flash_courier/models/address_model.dart';
import 'package:teste_flash_courier/views/registration/address_registration_view_widgets/form_widget/custom_input_widget/registration_view_custom_input.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key, this.address}) : super(key: key);
  final AddressModel? address;
  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomInputWidget(
                  type: TextInputType.text,
                  onSaved: (String? pais) {
                    widget.address?.country = pais!;
                  },
                  hint: "País",
                ),
              ),
              Expanded(
                child: CustomInputWidget(
                  type: TextInputType.text,
                  onSaved: (String? estado) {
                    widget.address?.state = estado!;
                  },
                  hint: "Estado",
                ),
              )
            ],
          ),
          CustomInputWidget(
            type: TextInputType.text,
            onSaved: (String? cidade) {
              widget.address?.district = cidade!;
            },
            hint: "Cidade",
          ),
          Row(
            children: [
              Expanded(
                child: CustomInputWidget(
                  type: TextInputType.number,
                  inputFormatters: [
                    // obrigatório
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(),
                  ],
                  onSaved: (String? cep) {
                    widget.address?.zipCode =
                        int.parse(cep!.replaceAll('.', '').replaceAll('-', ''));
                  },
                  hint: "CEP",
                ),
              ),
              Expanded(
                child: CustomInputWidget(
                  type: TextInputType.number,
                  onSaved: (String? numero) {
                    widget.address?.number = int.parse(numero!);
                  },
                  hint: "Número",
                ),
              )
            ],
          ),
          CustomInputWidget(
            type: TextInputType.text,
            onSaved: (String? rua) {
              widget.address?.street = rua!;
            },
            hint: "Rua",
          ),
        ],
      ),
    );
  }
}

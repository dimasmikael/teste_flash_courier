import 'package:flutter/material.dart';
import 'package:teste_flash_courier/models/address_model.dart';
import 'package:teste_flash_courier/shared/card/custom-card/custom_card_widget.dart';
import 'package:teste_flash_courier/shared/style/text/style_text.dart';

class TextDetailsWidget extends StatelessWidget {
  const TextDetailsWidget(this.address, {Key? key}) : super(key: key);
  final AddressModel? address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomCardWidget(
          widgets: Column(children: [
            textInfoDetails('País: ${address?.country ?? ''}'),
            textInfoDetails('Estado: ${address?.state ?? ''}'),
            textInfoDetails('Cidade: ${address?.city ?? ''}'),
          ]),
        ),
        const Divider(
          thickness: 3,
        ),
        CustomCardWidget(
          widgets: Column(children: [
            textInfoDetails('CEP: ${address?.zipCode ?? 0}'),
            textInfoDetails('Bairro: ${address?.district ?? 0}'),
            textInfoDetails('Logradouro: ${address?.street ?? ''}'),
            textInfoDetails('Número: ${address?.number ?? 0}'),
          ]),
        ),
      ],
    );
  }
}

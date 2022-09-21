import 'package:flutter/material.dart';
import 'package:teste_flash_courier/models/address_model.dart';
import 'package:teste_flash_courier/shared/appbar/custom_appbar.dart';

import 'package:teste_flash_courier/shared/config/size-config/size-config.dart';
import 'package:teste_flash_courier/shared/style/text/style_text.dart';
import 'package:teste_flash_courier/views/details/widgets/image_details_widget.dart';
import 'package:teste_flash_courier/views/details/widgets/texto_details_widget.dart';

class DetailsView extends StatefulWidget {
  const DetailsView(this.address, {Key? key}) : super(key: key);
  final AddressModel? address;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    print(widget.address?.photoCountry.length ?? 21212);
    SizeConfig().init(context);
    return Scaffold(
      appBar: const CustomAppBar(text: 'Details Address'),
      body: Center(
        child: SizedBox(
          height: SizeConfig.screenHeight!,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ImagemDetailsWidget(widget.address),
                TextDetailsWidget(widget.address)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

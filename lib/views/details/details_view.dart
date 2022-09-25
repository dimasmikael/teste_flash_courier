import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_flash_courier/models/address_model.dart';
import 'package:teste_flash_courier/shared/appbar/custom_appbar.dart';

import 'package:teste_flash_courier/shared/config/size-config/size-config.dart';
import 'package:teste_flash_courier/shared/style/text/style_text.dart';
import 'package:teste_flash_courier/views/details/widgets/form_edit_widget.dart';
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
  void dispose() {
    super.dispose();
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => FormEditWidget(
              address: widget.address,
            ),
          ),
        )
        .then(
          (value) => Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => DetailsView(widget.address),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
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
                TextDetailsWidget(widget.address),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 200.0,
                    height: 50.0,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.orange,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () => _navigateToNextScreen(context),
                      child: const Text(
                        'Editar',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

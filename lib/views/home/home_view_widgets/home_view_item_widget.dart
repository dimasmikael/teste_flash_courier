import 'package:flutter/material.dart';
import 'package:teste_flash_courier/models/address_model.dart';
import 'package:teste_flash_courier/shared/config/size-config/size-config.dart';
import 'package:teste_flash_courier/shared/style/text/style_text.dart';

class HomeViewItemWidget extends StatelessWidget {
  AddressModel? address;
  VoidCallback? onTapItem;
  VoidCallback? onPressedRemover;

  HomeViewItemWidget(
      {Key? key, required this.address, this.onTapItem, this.onPressedRemover})
      : super(key: key);

  Widget _getItemUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: SizeConfig.screenWidth! * .30,
              height: SizeConfig.screenHeight! * .15,
              child: Image.network(
                address!.photoCountry[0],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textNamePlace('País: ${address?.country ?? ''}'),
                          subTextNamePlace('Estado: ${address?.state ?? ""}'),
                          subTextNamePlace(
                              'Cidade: ${address?.city ?? ""}'),
                        ],
                      ),
                    ),
                  ),
                  if (onPressedRemover != null)
                    Expanded(
                      child: TextButton(
                        onPressed: onPressedRemover,
                        child: const Text('Delete'),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: onTapItem,
      child: _getItemUI(context),
    );
  }
}

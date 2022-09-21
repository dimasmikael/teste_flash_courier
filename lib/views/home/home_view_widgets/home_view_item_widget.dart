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
                              'Cidade: ${address?.district ?? ""}'),
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
            // Text(
            //   address?.district ?? "55656565",
            //   style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,color: Colors.orangeAccent),
            // // ),
            // subtitle: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children:  <Widget>[
            //       // const Text("_allCities[index].country",
            //       //     style: TextStyle(
            //       //         fontSize: 13.0, fontWeight: FontWeight.normal)),
            //       const Text('Population: ${"_allCities[index].population"}',
            //           style: TextStyle(
            //               fontSize: 11.0, fontWeight: FontWeight.normal)),

            //         if (onPressedRemover != null)
            //
            // TextButton(
            //   onPressed: onPressedRemover,
            //   child: const Text('Delete'),
            // )
            //    ]),
            //trailing: ,
            // onTap: () {
            //   _showSnackBar(context, _allCities[index]);
            // },
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(onTap: onTapItem, child: _getItemUI(context)
        // Card(
        //   child: Padding(
        //     padding: const EdgeInsets.all(12),
        //     child: Row(
        //       children: <Widget>[
        //         SizedBox(
        //           width: 120,
        //           height: 120,
        //           child: Image.network(
        //             address!.photoCountry[0],
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //         Expanded(
        //           flex: 3,
        //           child: Padding(
        //             padding:
        //                 const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: <Widget>[
        //                 Text(
        //                   address?.state ?? "",
        //                   style: const TextStyle(
        //                       fontSize: 18, fontWeight: FontWeight.bold),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         Expanded(
        //           flex: 3,
        //           child: Padding(
        //             padding:
        //                 const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: <Widget>[
        //                 Text(
        //                   address?.district ?? "",
        //                   style: const TextStyle(
        //                       fontSize: 18, fontWeight: FontWeight.bold),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),

        //
        //               //
        //               // FlatButton(
        //               //   color: Colors.red,
        //               //   padding: const EdgeInsets.all(10),
        //               //   onPressed: onPressedRemover,
        //               //   child: const Icon(
        //               //     Icons.delete,
        //               //     color: Colors.white,
        //               //   ),
        //               // ),
        //               )
        //         //botao remover
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}

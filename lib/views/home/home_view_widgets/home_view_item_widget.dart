import 'package:flutter/material.dart';
import 'package:teste_flash_courier/models/address_model.dart';

class HomeViewItemWidget extends StatelessWidget {
  AddressModel? address;
  VoidCallback? onTapItem;
  VoidCallback? onPressedRemover;

  HomeViewItemWidget(
      {Key? key, required this.address, this.onTapItem, this.onPressedRemover})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 120,
                height: 120,
                child: Image.network(
                  address!.photoCountry![0],
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        address?.state ?? "",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        address?.district ?? "",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              if (onPressedRemover != null)
                Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: onPressedRemover,
                      child: const Text('Delete'),
                    )

                    //
                    // FlatButton(
                    //   color: Colors.red,
                    //   padding: const EdgeInsets.all(10),
                    //   onPressed: onPressedRemover,
                    //   child: const Icon(
                    //     Icons.delete,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    )
              //botao remover
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget({Key? key, required this.widgets}) : super(key: key);
  final Widget? widgets;

  Card customCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
              contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
              subtitle: widgets),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return customCard();
  }
}

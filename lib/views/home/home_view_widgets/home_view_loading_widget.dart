import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const <Widget>[
          Text("Carregando endereços"),
          CircularProgressIndicator(
            color: Colors.orangeAccent,
          )
        ],
      ),
    );
  }
}

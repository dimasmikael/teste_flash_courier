import 'package:flutter/material.dart';
class CustomButtonWidget extends StatelessWidget {

  final String text;
  final Color? colorText;
  final VoidCallback? onPressed;

  CustomButtonWidget({
    required this.text,
    this.colorText = Colors.white,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return

      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xff9c27b0),

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6)
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: colorText, fontSize: 20
          ),
        ),
      );


  }
}
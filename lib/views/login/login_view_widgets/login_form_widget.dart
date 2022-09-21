import 'package:flutter/material.dart';

class FormLoginWidget extends StatelessWidget {
  const FormLoginWidget(this.controllerEmail, this.controllerPassword,
      {Key? key})
      : super(key: key);
  final TextEditingController? controllerEmail;
  final TextEditingController? controllerPassword;

  Column formLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controllerEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Email",
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: controllerPassword,
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Senha",
            enabledBorder: OutlineInputBorder(
              //  borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
                width: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return formLogin();
  }
}

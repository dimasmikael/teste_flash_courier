import 'package:flutter/material.dart';

class FormLoginWidget extends StatelessWidget {
  const FormLoginWidget(this.controllerEmail, this.controllerSenha, {Key? key})
      : super(key: key);
  final TextEditingController? controllerEmail;
  final TextEditingController? controllerSenha;

  Column formLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text(
        //   "Email",
        //   style: TextStyle(color: Color(0xFF707070), fontSize: 18),
        // ),
        TextFormField(
          controller: controllerEmail,
          //   autofocus: true,
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
              //  borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            // enabledBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(
            //     color: Color(0xFF707070),
            //   ),
            // ),
            // focusedBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(
            //     color: Color(0xFF707070),
            //   ),
            // ),
          ),
        ),
        const SizedBox(height: 20),
        // const Text(
        //   "Senha",
        //   style: TextStyle(color: Color(0xFF707070), fontSize: 18),
        // ),
        TextFormField(
          controller: controllerSenha,
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

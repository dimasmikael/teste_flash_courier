import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;

  final bool autofocus;
  final TextInputType type;

  final List<TextInputFormatter>? inputFormatters;

  final void Function(String?)? onSaved;
  const CustomInputWidget(
      {Key? key,
      this.controller,
      required this.hint,
      this.autofocus = false,
      this.type = TextInputType.text,
      this.inputFormatters,
      this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'campo obrigatório';
          }
          return null;
        },
        onSaved: onSaved,
        controller: controller,
        autofocus: autofocus,
        keyboardType: type,
        inputFormatters: inputFormatters,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.sentences,
        maxLines: 1,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              6,
            ),
          ),
        ),
      ),
    );
  }
}

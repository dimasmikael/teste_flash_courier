import 'package:flutter/material.dart';
import 'package:teste_flash_courier/shared/config/size-config/size-config.dart';

class LoginImageWidget extends StatelessWidget {
  const LoginImageWidget({Key? key}) : super(key: key);

  Padding backgroundImage() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        height: SizeConfig.safeBlockVertical! * 45,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/logo.png"),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return backgroundImage();
  }
}

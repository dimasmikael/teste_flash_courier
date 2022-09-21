import 'package:flutter/material.dart';
import 'package:teste_flash_courier/shared/config/size-config/size-config.dart';
import 'package:teste_flash_courier/shared/style/text/style_text.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key, this.text}) : super(key: key);
  final String? text;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return PreferredSize(
      preferredSize: Size.fromHeight(
        SizeConfig.blockSizeVertical! * 12,
      ),
      child: AppBar(
        centerTitle: true,
        elevation: 2,
        iconTheme: IconThemeData(
            size: SizeConfig.safeBlockHorizontal! * 6, color: Colors.white),
        title: textAppBar(text!),
      ),
    );
  }
}

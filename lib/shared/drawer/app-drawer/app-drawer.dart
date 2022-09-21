import 'package:flutter/material.dart';
import 'package:teste_flash_courier/controllers/user_controller.dart';

class AppDrawer extends StatelessWidget {
  UserController? userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: Text('Menu'),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () {
                userController?.getLogoutUser(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

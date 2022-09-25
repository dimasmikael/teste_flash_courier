import 'package:flutter/material.dart';
import 'package:teste_flash_courier/controllers/user_controller.dart';
import 'package:teste_flash_courier/models/usuario_model.dart';
import 'package:teste_flash_courier/shared/config/size-config/size-config.dart';
import 'package:teste_flash_courier/views/login/login_view_widgets/login_form_widget.dart';
import 'package:teste_flash_courier/views/login/login_view_widgets/login_image_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  UserController? userController;

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  String _errorMessage = "";
  bool _register = false;
  String _textButton = "Entrar";

  @override
  void initState() {
    super.initState();
    userController = UserController();
  }

  @override
  void dispose() {
    super.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
  }

  _validateFields(BuildContext context) async {
    String email = controllerEmail.text;
    String password = controllerPassword.text;

    if (controllerEmail.text.isEmpty || controllerPassword.text.isEmpty) {
      setState(
        () {
          _errorMessage = "Verifique email e senha";
        },
      );
    } else {
      if (email.isNotEmpty && email.contains("@")) {
        if (password.isNotEmpty && password.length > 6) {
          UserModel user = UserModel();
          user.email = email;
          user.password = password;

          if (_register) {
            userController?.getRegisterUser(user, context);
          } else {
            userController?.getLoginUser(user, context);
          }
        } else {
          setState(
            () {
              _errorMessage = "Preencha a senha! digite mais de 6 caracteres";
            },
          );
        }
      } else {
        setState(
          () {
            _errorMessage = "Preencha o E-mail válido";
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: const Color(0xff6A8EC8),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: const [
                LoginImageWidget(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLoginWidget(
                    controllerEmail,
                    controllerPassword,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Logar",
                          style: TextStyle(color: Colors.white)),
                      Switch(
                        activeColor: Colors.white,
                        value: _register,
                        onChanged: (bool value) {
                          setState(() {
                            _register = value;
                            _textButton = "Entrar";
                            if (_register) {
                              _textButton = "Cadastrar";
                            }
                          });
                        },
                      ),
                      const Text("Cadastrar",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            _validateFields(context);
                          },
                          child: Container(
                            height: SizeConfig.safeBlockVertical! * 10,
                            width: SizeConfig.safeBlockHorizontal! * 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xffE5B633),
                            ),
                            child: Center(
                              child: Text(
                                _textButton,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

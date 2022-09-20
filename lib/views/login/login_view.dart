import 'package:flutter/material.dart';
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
  final TextEditingController controllerEmail =
      TextEditingController(text: 'teste4@gmail.com');
  final TextEditingController controllerPassword =
      TextEditingController(text: '1234567');

  String _errorMessage = "";
   bool _register = false;
  String _textButton = "Entrar";


  _cadastrarUsuario(UserModel user) {
    // FirebaseAuth auth = FirebaseAuth.instance;
    //
    // auth
    //     .createUserWithEmailAndPassword(
    //     email: usuario.email, password: usuario.senha)
    //     .then((firebaseUser) {
    //   //redireciona para tela principal
    //   //   Navigator.pushReplacementNamed(context, '/home');
    //
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (_) => const HomeView()));
    // });
  }


  _logarUsuario(UserModel user) {
    // FirebaseAuth auth = FirebaseAuth.instance;
    //
    // auth
    //     .signInWithEmailAndPassword(
    //     email: usuario.email, password: usuario.senha)
    //     .then((firebaseUser) {
    //   //redireciona para tela principal
    //   //  Navigator.pushReplacementNamed(context, '/home');
    //
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (_) => const HomeView()));
    // });
  }

  _validarCampos() {
    //Recupera dados dos campos
    String email = controllerEmail.text;
    String password = controllerPassword.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (password.isNotEmpty && password.length > 6) {
        //Configura usuario
        UserModel user = UserModel();
        user.email = email;
        user.password = password;

        //cadastrar ou logar
        if (_register) {
          //Cadastrar
          _cadastrarUsuario(user);
        } else {
          //Logar
          _logarUsuario(user);
        }
      } else {
        setState(
              () {
            _errorMessage  = "Preencha a senha! digite mais de 6 caracteres";
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
                // TitleSubtileWidget(),
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
                  //  const SizedBox(height: 15),
                  //   forgetButton(),
                  //  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Logar", style: TextStyle(
                          color: Colors.white)),
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
                      const Text("Cadastrar",style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            _validarCampos();
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
                                color: Colors.red),
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

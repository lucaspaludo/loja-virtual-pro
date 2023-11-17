import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/helpers/validators.dart';
import 'package:loja_virtual_pro/models/user.dart';
import 'package:loja_virtual_pro/models/userManager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Entrar"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            child: const Text(
              'CRIAR CONTA',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, child) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(
                        hintText: "E-mail",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValid(email!)) {
                          return "E-mail Inválido";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: passController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(
                        hintText: "Senha",
                      ),
                      autocorrect: false,
                      obscureText: true,
                      validator: (pass) {
                        if (pass!.isEmpty || pass.length < 6) {
                          return "Senha inválida";
                        }
                        return null;
                      },
                    ),
                    child!,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        disabledBackgroundColor: primaryColor,
                      ),
                      onPressed: userManager.loading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                userManager.signIn(
                                    UserData(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passController.text,
                                      id: '',
                                    ), onFail: (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('$e'),
                                    backgroundColor: Colors.red,
                                  ));
                                }, onSucess: () {
                                  Navigator.of(context).pop();
                                });
                              }
                            },
                      child: userManager.loading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text('Entrar'),
                    ),
                  ],
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Esqueci minha senha',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/helpers/validators.dart';
import 'package:loja_virtual_pro/models/user.dart';
import 'package:loja_virtual_pro/models/userManager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final UserData user = UserData(email: "", password: "", name: "", id: "");

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Nome Completo'),
                      enabled: !userManager.loading,
                      validator: (nome) {
                        if (nome!.isEmpty) {
                          return 'Campo obrigatóiro';
                        } else if (nome.trim().split(' ').length <= 1) {
                          return 'Preencha seu nome completo';
                        }
                        return null;
                      },
                      onSaved: (name) => user.name = name!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if (email!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (!emailValid(email)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                      onSaved: (email) => user.email = email!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (pass) {
                        if (pass!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (pass.length < 6) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                      onSaved: (pass) => user.password = pass!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Repita a senha'),
                      obscureText: true,
                      enabled: !userManager.loading,
                      validator: (pass) {
                        if (pass!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (pass.length < 6) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                      onSaved: (pass) => user.confirmPassword = pass!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: userManager.loading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                if (user.password != user.confirmPassword) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Senhas não coincidem!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                userManager.signUp(
                                  user,
                                  onFail: (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('$e'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                  onSucess: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      child: userManager.loading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text(
                              'Criar Conta',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

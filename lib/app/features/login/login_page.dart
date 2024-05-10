import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puc_minas/app/core/constants/app_assets.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:puc_minas/app/features/login/login_controller.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cpfEC = TextEditingController();
  final passwordEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(AppAssets.logo),
                TextFormField(
                  controller: cpfEC,
                  validator: Validatorless.multiple(
                    ([Validatorless.required('Campo Obrigatório')]),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Insira seu CPF',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordEC,
                  validator: Validatorless.multiple(
                    ([Validatorless.required('Campo Obrigatório'), Validatorless.min(6, 'Mínimo de 6 caracteres')]),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Insira sua Senha',
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    bool valid = formKey.currentState?.validate() ?? false;

                    if (valid) {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.info(message: 'Aguarde...'),
                        snackBarPosition: SnackBarPosition.top,
                      );

                      bool success = await LoginController.login(
                        cpf: cpfEC.text.replaceAll('.', '').replaceAll('-', ''),
                        password: passwordEC.text,
                      );

                      if (success) {
                        Navigator.of(context).pushNamed(AppRoutes.home);
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.success(message: 'Você efetuou o login!'),
                          snackBarPosition: SnackBarPosition.top,
                        );
                      } else {
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.error(
                            message: 'Os dados informados não conferem',
                          ),
                        );
                      }
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ACESSAR'),
                      SizedBox(width: 10),
                      Icon(Icons.login),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

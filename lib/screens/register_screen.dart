import 'package:flutter/material.dart';
import 'package:form_login/providers/login_provider.dart';
import 'package:form_login/screens/screens.dart';
import 'package:form_login/services/services.dart';
import 'package:form_login/ui/input_decorations.dart';
import 'package:form_login/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  static const String route = 'register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Crear Cuenta',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ChangeNotifierProvider(
                      create: (context) => LoginFormProvider(),
                      child: const _LoginForm(),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                    overlayColor: MaterialStateProperty.all(
                        Colors.deepPurple.withOpacity(0.1))),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, LoginScreen.route);
                },
                child: const Text(
                  '¿Ya tienes una cuenta?',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hinText: 'javicho@gmail.com',
                labelText: 'Correo electronico',
                icon: Icons.alternate_email_outlined,
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no es un correo';
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              obscureText: true,
              autocorrect: false,
              // keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                  hinText: '***********',
                  labelText: 'Password',
                  icon: Icons.lock_outline),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'Contraseña minimo debe tener 6 caracteres';
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final authServices =
                          Provider.of<AuthServices>(context, listen: false);
                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = true;

                      final String? errorMessage = await authServices
                          .registerUser(loginForm.email, loginForm.password);

                      if (errorMessage == null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.route);
                      } else {
                        print(errorMessage);
                        loginForm.isLoading = false;
                      }
                    },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Enviado' : 'Enviar',
                ),
              ),
            )
          ],
        ));
  }
}

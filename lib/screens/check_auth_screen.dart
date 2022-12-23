import 'package:flutter/material.dart';
import 'package:form_login/screens/screens.dart';
import 'package:form_login/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  static const String route = 'check';
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context, listen: false);
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: authService.readToken(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator(
              color: Colors.deepPurple,
            );
          }

          if (snapshot.data == '') {
            Future.microtask(
              () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(seconds: 0),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const LoginScreen(),
                  ),
                );
              },
            );
          } else {
            Future.microtask(
              () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(seconds: 0),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HomeScreen(),
                  ),
                );
              },
            );
          }

          return Container();
        },
      )),
    );
  }
}

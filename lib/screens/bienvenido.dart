import 'package:flutter/material.dart';

class BienvenidoScreen extends StatelessWidget {
  static const String route = 'welcome';
  const BienvenidoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset('assets/avatar.jpg'),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.supervised_user_circle,
                    size: 30,
                    color: Colors.deepPurple,
                  ),
                  title: Text('Javier Enrique Choquetico Condori'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.alternate_email_rounded,
                    size: 30,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    'javier@gmail.com',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.privacy_tip_outlined,
                    size: 30,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    'Datos y Privacidad',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.lock_clock_rounded,
                    size: 30,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    'Seguridad',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.wallet_giftcard,
                    size: 30,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    'Pagos y Suscripciones',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

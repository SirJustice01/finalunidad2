import 'package:flutter/material.dart';
import 'package:form_login/screens/bienvenido.dart';

import 'package:form_login/screens/screens.dart';
import 'package:form_login/services/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsService(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthServices(),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: NotificationServices.messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      initialRoute: CheckAuthScreen.route,
      routes: {
        HomeScreen.route: (_) => const HomeScreen(),
        LoginScreen.route: (_) => const LoginScreen(),
        ProductScreen.route: (_) => const ProductScreen(),
        RegisterScreen.route: (_) => const RegisterScreen(),
        CheckAuthScreen.route: (_) => const CheckAuthScreen(),
        BienvenidoScreen.route: (_) => const BienvenidoScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple),
      ),
    );
  }
}

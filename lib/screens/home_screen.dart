import 'package:flutter/material.dart';
import 'package:form_login/models/models.dart';
import 'package:form_login/screens/bienvenido.dart';

import 'package:form_login/screens/loading_screen.dart';
import 'package:form_login/screens/screens.dart';
import 'package:form_login/services/services.dart';
import 'package:form_login/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String route = 'home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthServices>(context);
    if (productsService.isLoading) return const LoadingScreen();

    const textStyle = TextStyle(fontSize: 20);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: Image.asset(
                      'assets/descarga.jpg',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Linio',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () => Navigator.pushNamed(context, BienvenidoScreen.route),
              leading: const Icon(
                Icons.message,
                color: Colors.deepPurple,
                size: 30,
              ),
              title: const Text(
                'Messages',
                style: textStyle,
              ),
            ),
            ListTile(
              onTap: () => Navigator.pushNamed(context, BienvenidoScreen.route),
              leading: const Icon(
                Icons.account_circle,
                size: 30,
                color: Colors.deepPurple,
              ),
              title: const Text(
                'Profile',
                style: textStyle,
              ),
            ),
            ListTile(
              onTap: () => Navigator.pushNamed(context, BienvenidoScreen.route),
              leading: const Icon(
                Icons.settings,
                size: 30,
                color: Colors.deepPurple,
              ),
              title: const Text(
                'Settings',
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Productos'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, LoginScreen.route);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (context, i) => GestureDetector(
          onTap: () {
            productsService.selectedProduct =
                productsService.products[i].copy();
            Navigator.pushNamed(context, ProductScreen.route);
          },
          child: ProductCard(
            product: productsService.products[i],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct =
              Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, ProductScreen.route);
        },
      ),
    );
  }
}

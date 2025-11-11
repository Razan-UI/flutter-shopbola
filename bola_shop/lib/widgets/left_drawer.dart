import 'package:flutter/material.dart';
import 'package:bola_shop/menu.dart';
import 'package:bola_shop/screens/productlist_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Text(
                  'Football Shop',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text("Browse Football-related products here!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                    ),
              ],
            ),
          ),
                  ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Main Homepage'),
          // Bagian redirection ke MyHomePage
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.post_add),
          title: const Text('Add Products'),
          // Bagian redirection ke NewsFormPage
          onTap: () {Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProductFormPage(),
            ));
          },
        ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/text_string.dart';
import 'formulaire_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer Example'),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        shape: CircleBorder(),
        onPressed: () => Get.to(() => FormPage()),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color:
                    TColors.primary, // Couleur de fond de l'en-tête du tiroir
              ),
              child: Center(
                child: CircleAvatar(
                  // Utilisation de l'image dans le drawer
                  radius: 80,
                ),
              )),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(TTexts.homedrawer),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/profil");
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text(TTexts.demandesdrawer),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(TTexts.deconnexiondrawer),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        DrawerHeader(
            child: Center(
          child: CircleAvatar(
            // Utilisation de l'image dans le drawer
            backgroundImage: AssetImage("images/2920072.png"),
            radius: 80,
          ),
        )),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('     P  R  O  F  I  L  E'),
          trailing: Icon(Icons.arrow_right_alt_rounded, color: Colors.black),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, "/profil");
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('     P A R A M E T R E S'),
        ),
      ],
    ));
  }
}

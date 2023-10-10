import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: Image.asset('images/Logo/1x/Icon_1@1x.png'),
      color: Colors.green,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Text(
      'SAMLAH',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.notifications),
        color: Colors.grey[600],
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.qr_code_scanner),
        color: Colors.grey[600],
      ),
    ],
  );
}

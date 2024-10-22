import 'package:flutter/material.dart';

class CustomMaterial extends StatelessWidget {
  const CustomMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
        ),
        title: Text("Content"),
      ),
    );
  }
}

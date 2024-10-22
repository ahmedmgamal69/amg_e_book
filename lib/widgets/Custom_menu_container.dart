import 'package:flutter/material.dart';

class CustomMenuContainer extends StatelessWidget {
  final String? menuTitle;
  final Color? menuColor;
  const CustomMenuContainer({super.key, this.menuTitle, this.menuColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 50.0,
      child: Text(
        this.menuTitle!,
        style: TextStyle(color: Colors.white),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: this.menuColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 7,
              offset: Offset(0, 0),
            )
          ]),
    );
  }
}

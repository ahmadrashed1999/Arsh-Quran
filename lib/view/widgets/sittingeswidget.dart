import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SittingsCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function()? onTap;
  const SittingsCard({
    Key? key,
    required this.iconData,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff081945)),
        child: ListTile(
            leading: Icon(
              iconData,
              color: Colors.orange,
            ),
            title: Text(title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ))),
      ),
    );
  }
}

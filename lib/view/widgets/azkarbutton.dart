import 'package:flutter/material.dart';

class AzkarButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const AzkarButton({Key? key, this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.orange,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: onTap,
      child: Text('العدات : ${text}'),
    );
  }
}

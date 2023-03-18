import 'package:flutter/material.dart';
import 'package:quranarsh/constant/colors.dart';

class AzkarWidget extends StatelessWidget {
  final IconData iconData;
  final Function()? onTap;
  const AzkarWidget({Key? key, required this.iconData, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onTap,
        icon: Icon(
          iconData,
          color: iconColor,
        ));
  }
}

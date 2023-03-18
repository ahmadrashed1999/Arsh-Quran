import 'package:flutter/material.dart';
import 'package:quranarsh/constant/colors.dart';

class HomePageCard extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final String image;
  const HomePageCard(
      {Key? key, this.onTap, required this.text, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient:  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                    cardColor1,
                    cardColor1,
                    ],
                  )),
            ),
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    opacity: 0.5,
                    image: AssetImage(image),
                    fit: BoxFit.scaleDown),
              ),
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

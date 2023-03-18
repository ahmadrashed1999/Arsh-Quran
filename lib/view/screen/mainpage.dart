import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:quranarsh/constant/colors.dart';
import 'package:quranarsh/view/screen/homepage.dart';
import 'package:quranarsh/view/screen/qiblah.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pageController = PageController(initialPage: 0);

  int maxCount = 5;

  /// widget list
  final List<Widget> bottomBarPages = [const HomePage(), Qiblah()];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        extendBody: true,
        bottomNavigationBar: AnimatedNotchBottomBar(
          pageController: _pageController,
          bottomBarItems:  [
            BottomBarItem(
              inActiveItem: const Icon(
                Icons.home_filled,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.home_filled,
                color:iconColor
              ),
              itemLabel: 'الرئيسية',
            ),
            BottomBarItem(
              inActiveItem: const Icon(
                Icons.location_on_rounded,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.location_on_rounded,
                color:iconColor
              ),
              itemLabel: 'القبلة',
            ),
          ],
          onTap: (int value) {
            _pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
        ));
  }
}

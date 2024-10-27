import 'package:archive/common/custom_icons.dart';
import 'package:archive/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:archive/pages/profile.dart';
import 'package:archive/widgets/ar_screen.dart'; // Importing ARWidget
import 'package:heroicons/heroicons.dart';

class MainTabNavigator extends StatelessWidget {
  const MainTabNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: const Color.fromARGB(255, 10, 10, 10),
        inactiveColor: const Color.fromARGB(255, 255, 255, 255),
        activeColor: const Color.fromARGB(255, 255, 255, 255),
        onTap: (value) => {HapticFeedback.selectionClick()},
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: HeroIcon(
            HeroIcons.homeModern,
            style: HeroIconStyle.outline,
            color: Colors.white,
            size: 30,
          )),
          BottomNavigationBarItem(
              icon: HeroIcon(
            HeroIcons.user,
            style: HeroIconStyle.outline,
            color: Colors.white,
            size: 30,
          )),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(builder: (BuildContext context) {
          return Stack(
            children: [
              index == 0 ? const HomePage() : const ProfilePage(),
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 5,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 10, 10, 10),
                        border: Border(
                            top: BorderSide(
                                color: Color.fromARGB(255, 32, 32, 32),
                                width: 1))),
                  )),
              Positioned(
                left: index == 0
                    ? MediaQuery.of(context).size.width / 4 - 35
                    : MediaQuery.of(context).size.width / 2 +
                        MediaQuery.of(context).size.width / 4 -
                        35,
                bottom: 0,
                child: Container(
                    height: 5,
                    width: 75,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 147, 183, 190),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 147, 183, 190),
                            blurRadius: 10,
                            offset: Offset(0, 1)),
                      ],
                    )),
              )
            ],
          );
        });
      },
    );
  }
}

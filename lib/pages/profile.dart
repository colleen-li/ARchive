import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final viewWidth = MediaQuery.of(context).size.width;
    final viewHeight = MediaQuery.of(context).size.height;

    return CupertinoPageScaffold(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: <Widget>[
            //logo
            Positioned(
              top: (1/(15)) * viewHeight,
              child: Container(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/svg/logo.svg",
                  height: 75,
                  width: 75,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            //profile
            Positioned(
              top: (1/6) * viewHeight,
              left: (1/16) * viewWidth,
              height: 150,
              width: viewWidth - 50,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xff202020),
                ),
              ),
            ),
            Positioned(
              top: (1/(4.8)) * viewHeight,
              left: (1/7) * viewWidth,
              height: 80,
              width: 80,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xffFFFFFF),
                ),
              ),
            ),
            Positioned(
              top: (1/5) * viewHeight,
              left: (1/2) * viewWidth,
              child: Text("USERNAME"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:archive/widgets/brand_button.dart';

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
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: <Widget>[
            //logo
            Positioned(
              top: (1 / (15)) * viewHeight,
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
              top: (1 / 6) * viewHeight,
              left: (1 / 16) * viewWidth,
              height: 200,
              width: viewWidth - 50,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xff202020),
                ),
              ),
            ),
            Positioned(
              top: (1 / (4.8)) * viewHeight,
              left: (1 / 7) * viewWidth,
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
              top: (1 / 5) * viewHeight,
              left: ((1 / 2) * viewWidth) - 45,
              child: Text(
                  FirebaseAuth.instance.currentUser?.displayName != null
                      ? FirebaseAuth.instance.currentUser!.displayName!
                      : "ARchive User",
                  style: (TextStyle(
                    fontWeight: FontWeight.bold,
                  ))),
            ),
            Positioned(
              top: ((1 / 5) * viewHeight) + 25,
              left: ((1 / 2) * viewWidth) - 45,
              child: Text("Add Pronouns • Purdue'28 | @purduecs",
                  style: (TextStyle(
                      fontSize: 12, color: Colors.white.withOpacity(0.5)))),
            ),
            //Quotes
            Positioned(
              top: ((1 / 5) * viewHeight) + 50,
              left: ((1 / 2) * viewWidth) - 25,
              child: Text("#",
                  style: (TextStyle(fontSize: 16, color: Colors.white))),
            ),
            Positioned(
              top: ((1 / 5) * viewHeight) + 80,
              left: ((1 / 2) * viewWidth) - 45,
              child: Text("Quotes",
                  style: (TextStyle(
                      fontSize: 14, color: Colors.white.withOpacity(0.5)))),
            ),
            //Followers
            Positioned(
              top: ((1 / 5) * viewHeight) + 50,
              left: ((1 / 2) * viewWidth) + 45,
              child: Text("#",
                  style: (TextStyle(fontSize: 16, color: Colors.white))),
            ),
            Positioned(
              top: ((1 / 5) * viewHeight) + 80,
              left: ((1 / 2) * viewWidth) + 20,
              child: Text("Followers",
                  style: (TextStyle(
                      fontSize: 14, color: Colors.white.withOpacity(0.5)))),
            ),
            //Following
            Positioned(
              top: ((1 / 5) * viewHeight) + 50,
              left: ((1 / 2) * viewWidth) + 120,
              child: Text("#",
                  style: (TextStyle(fontSize: 16, color: Colors.white))),
            ),
            Positioned(
              top: ((1 / 5) * viewHeight) + 80,
              left: ((1 / 2) * viewWidth) + 95,
              child: Text("Following",
                  style: (TextStyle(
                      fontSize: 14, color: Colors.white.withOpacity(0.5)))),
            ),
            // Positioned(
            //   child: Column(
            //       children: [
            //             Expanded(
            //               child: BrandButton(
            //                   onTap:() {

            //                   },
            //               ),
            //             ),
            //           ],
            //         ),
            // ),
          ],
        ),
      ),
    );
  }
}

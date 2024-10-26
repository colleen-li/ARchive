import 'package:archive/pages/main_tab_navigator.dart';
import 'package:archive/widgets/brand_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPage();
}

class _StartPage extends State<StartPage> {
  Future<void> loginWithApple() async {
    final appleProvider = AppleAuthProvider();
    if (kIsWeb) {
      await FirebaseAuth.instance.signInWithPopup(appleProvider).then((value) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => const MainTabNavigator(),
          ),
        );
      });
    } else {
      await FirebaseAuth.instance
          .signInWithProvider(appleProvider)
          .then((value) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => const MainTabNavigator(),
          ),
        );
      });
    }
  }

  Future<void> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => const MainTabNavigator(),
        ),
      );
    }).catchError((error) {
      debugPrint("Failed to log in with Google");
      return error;
    });
  }

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
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/background.jpg",
                height: viewHeight - 20,
                width: viewWidth - 20,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: (1 / 10) * viewHeight,
              left: (1 / 8) * viewWidth,
              child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/archive.png",
                    height: 150,
                    width: 330,
                  )),
            ),
            Positioned(
              top: (2.5 / 10) * viewHeight,
              left: (1 / 5) * viewWidth,
              child: Container(
                alignment: Alignment.center,
                child: const Text('Welcome Back.',
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 35)),
              ),
            ),
            Positioned(
              top: (3.2 / 10) * viewHeight,
              left: (1.1 / 4) * viewWidth,
              child: Container(
                alignment: Alignment.center,
                child: const Text('Log in with your account.'),
              ),
            ),
            Positioned(
              bottom: 125,
              child: Container(
                alignment: Alignment.center,
                width: 350.0,
                padding: const EdgeInsets.all(35),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.0, color: const Color.fromARGB(255, 23, 23, 23)),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    new BoxShadow(color: const Color(0xff000000)),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: BrandButton(
                              image: const AssetImage("assets/icons/apple.png"),
                              onTap: loginWithApple),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: BrandButton(
                              image:
                                  const AssetImage("assets/icons/google.png"),
                              onTap: loginWithGoogle),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

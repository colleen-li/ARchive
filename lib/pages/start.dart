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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        //Welcome MSG
        children: [
          Container(
            margin: EdgeInsets.all(8),
            alignment: Alignment.center,
            height: viewHeight,
            width: viewWidth - 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
                ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset("assets/images/archive.png"),
                  height: 120, 
                  width: 330,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Welcome Back!", style: TextStyle(fontSize: 35, letterSpacing: 3)),
                  height: 50, 
                  width: 330,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Log in with your account", style: TextStyle(fontSize: 18, letterSpacing: 1)),
                  height: 50, 
                  width: 330,
                ),
                Container(
                  height: 200,
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                )
            ],)
          ),
        ],
      )
    );
  }
}

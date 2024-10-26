import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPage();
}

class _StartPage extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/background.jpg",
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 100,
              left: 50,
              child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/archive.png",
                    height: 150,
                    width: 330,
                  )),
            ),
            Positioned(
              top: 250,
              left: 100,
              child: Container(
                alignment: Alignment.center,
                child: const Text('Welcome Back.',
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 35)),
              ),
            ),
            Positioned(
              top: 300,
              left: 120,
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
                height: 400.0,
                padding: const EdgeInsets.all(35),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 3.0, color: const Color(0xffD5C7BC)),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    const BoxShadow(color: const Color(0xffF1FFFA)),
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

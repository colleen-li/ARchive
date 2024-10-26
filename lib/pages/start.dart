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
    final viewWidth = MediaQuery.of(context).size.width;
    final viewHeight = MediaQuery.of(context).size.height;

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
                height: viewHeight - 20,
                width: viewWidth - 20,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: (1/10) * viewHeight,
              left: (1/8) * viewWidth,
              child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/archive.png",
                  height: 150,
                  width: 330,
                )
              ),
            ),
            Positioned(
              top: (2.5/10) * viewHeight,
              left: (1/5) * viewWidth,
              child: Container(
                alignment: Alignment.center,
                child: Text('Welcome Back.', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 35)),
              ),
            ),
            Positioned(
              top: (3.2/10) * viewHeight,
              left: (1.1/4) * viewWidth,
              child: Container(
                alignment: Alignment.center,
                child: Text('Log in with your account.'),
              ),
            ),
            Positioned(
              bottom: 125,
              child: Container(
                alignment: Alignment.center,
                width: 350.0,
                height: 400.0,
                padding: EdgeInsets.all(35),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(width: 3.0, color: const Color(0xff454545)),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    new BoxShadow(color: const Color(0xff000000)),
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
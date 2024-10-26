import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            "assets/svg/logo.svg",
            semanticsLabel: "ARchive Logo",
            height: 100,
            width: 100,
            fit: BoxFit.contain,
          ),
        )
      ],
    )));
  }
}

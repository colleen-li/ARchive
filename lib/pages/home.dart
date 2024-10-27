import 'package:archive/widgets/ar_screen.dart';
import 'package:archive/widgets/brand_button.dart';
import 'package:archive/widgets/post_toolbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heroicons/heroicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool _liked = false;

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
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height - 350,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: ARWidget(),
            )),
        const SizedBox(height: 10),
        SizedBox(
          height: 90,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Explore the world around you",
                    style: TextStyle(
                        fontSize: 16, color: Colors.white.withOpacity(0.75)),
                  ),
                  SizedBox(width: 5),
                  HeroIcon(
                    HeroIcons.globeAmericas,
                    size: 24,
                    color: Colors.white.withOpacity(0.75),
                  )
                ],
              )
            ],
          ),
        )
        // Container(
        //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        //   child: PostToolbar(
        //     liked: _liked,
        //     likes: 142 + (_liked ? 1 : 0),
        //     onLike: () {
        //       setState(() {
        //         _liked = !_liked;
        //       });
        //     },
        //     date: "10/24/24",
        //   ),
        // ),
      ],
    )));
  }
}

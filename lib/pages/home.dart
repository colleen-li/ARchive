import 'package:archive/widgets/ar_screen.dart';
import 'package:archive/widgets/post_toolbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: PostToolbar(
            liked: _liked,
            likes: 142 + (_liked ? 1 : 0),
            onLike: () {
              setState(() {
                _liked = !_liked;
              });
            },
            date: "10/24/24",
          ),
        ),
         Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 32, // Adjust width as needed
                  height: 800, // Set a fixed height or use MediaQuery for responsiveness
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const ARWidget(),
                ),
              ),
      ],
    )));
  }
}

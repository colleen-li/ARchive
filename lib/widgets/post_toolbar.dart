import 'package:archive/widgets/brand_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class PostToolbar extends StatefulWidget {
  final String date;
  final int likes;
  final bool liked;

  const PostToolbar({
    required this.likes,
    required this.liked,
    required this.date,
    super.key,
  });

  @override
  State<PostToolbar> createState() => _PostToolbar();
}

class _PostToolbar extends State<PostToolbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: 65,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 32, 32, 32),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 21, 21, 21),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeroIcon(
                    HeroIcons.handThumbUp,
                    color: Color.fromARGB(255, 147, 183, 190),
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${widget.likes}",
                    style: TextStyle(
                        fontSize: 14, color: Colors.white.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 21, 21, 21),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: HeroIcon(
                HeroIcons.chatBubbleBottomCenter,
                color: Color.fromARGB(255, 147, 183, 190),
                size: 24,
              )),
          const SizedBox(width: 10),
          Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 21, 21, 21),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: HeroIcon(
                HeroIcons.mapPin,
                color: Color.fromARGB(255, 120, 89, 100),
                size: 24,
              )),
          const SizedBox(width: 10),
          Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 21, 21, 21),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Center(
                child: Text(
                  "Imprinted ${widget.date}",
                  style: TextStyle(
                      fontSize: 12, color: Colors.white.withOpacity(0.5)),
                ),
              )),
        ],
      ),
    );
  }
}

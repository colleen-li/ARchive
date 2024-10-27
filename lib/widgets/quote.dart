import 'package:archive/widgets/post_toolbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Quote extends StatefulWidget {
  final String quote;

  const Quote({
    required this.quote,
    super.key,
  });

  @override
  State<Quote> createState() => _Quote();
}

class _Quote extends State<Quote> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromARGB(255, 31, 31, 31),
        ),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 21, 21, 21),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                '"${widget.quote}"',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          PostToolbar(
            date: "10/10/2021",
            likes: 10 + (_liked ? 1 : 0),
            liked: _liked,
            onLike: () {
              setState(() {
                _liked = !_liked;
              });
            },
          ),
        ]));
  }
}

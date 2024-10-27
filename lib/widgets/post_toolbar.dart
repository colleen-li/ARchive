import 'package:archive/api/models/post.dart';
import 'package:archive/widgets/brand_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class PostToolbar extends StatefulWidget {
  final IPost post;
  final bool liked;
  final int likes;
  final Function onLike;

  const PostToolbar({
    required this.onLike,
    required this.liked,
    required this.likes,
    required this.post,
    super.key,
  });

  @override
  State<PostToolbar> createState() => _PostToolbar();
}

class _PostToolbar extends State<PostToolbar> {
  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

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
              child: BrandButton(
            label: widget.likes.toString(),
            icon: HeroIcon(
              HeroIcons.handThumbUp,
              color: widget.liked
                  ? Color.fromARGB(255, 147, 183, 190)
                  : Colors.white.withOpacity(0.5),
              size: 24,
            ),
            type: BrandButtonType.matte,
            onTap: () {
              widget.onLike();
            },
          )),
          const SizedBox(width: 10),
          SizedBox(
            width: 45,
            child: BrandButton(
              icon: HeroIcon(
                HeroIcons.chatBubbleBottomCenter,
                color: Color.fromARGB(255, 147, 183, 190),
                size: 24,
              ),
              onTap: () => {
                showCupertinoModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    shape: Border.all(
                        width: 1.0,
                        color: const Color.fromARGB(255, 23, 23, 23)),
                    topRadius: Radius.circular(10),
                    barrierColor: Colors.black.withOpacity(0.5),
                    backgroundColor: const Color.fromARGB(255, 10, 10, 10),
                    builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                        ))
              },
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 45,
            child: BrandButton(
              icon: HeroIcon(
                HeroIcons.mapPin,
                color: Color.fromARGB(255, 120, 89, 100),
                size: 24,
              ),
              onTap: () => {
                navigateTo(widget.post.latitude, widget.post.longitude),
              },
            ),
          ),
          const SizedBox(width: 10),
          Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 21, 21, 21),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Imprinted",
                    style: TextStyle(
                        fontSize: 12, color: Colors.white.withOpacity(0.5)),
                  ),
                  Text(
                    "${widget.post.imprinted.month}/${widget.post.imprinted.day}/${widget.post.imprinted.year}",
                    style: TextStyle(
                        fontSize: 12, color: Colors.white.withOpacity(0.5)),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

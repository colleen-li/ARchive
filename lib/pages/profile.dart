import 'package:archive/api/models/post.dart';
import 'package:archive/api/services/post.dart';
import 'package:archive/pages/start.dart';
import 'package:archive/widgets/quote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:archive/widgets/brand_button.dart';
import 'package:archive/widgets/post_toolbar.dart';
import 'package:heroicons/heroicons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  PostService postService = PostService();
  List<IPost> _quotes = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    postService.getPostsById().then(
      (value) {
        debugPrint("Got posts: ${value.docs.length}");
        setState(() {
          _quotes = value.docs.map((e) => e.data()).toList();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          //Logo
          Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/svg/logo.svg",
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              )),
          //Profile
          Container(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
              width: 380,
              decoration: BoxDecoration(
                color: Color(0xff202020),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  //Profile Pic and Stats
                  Container(
                      width: 380,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      //Split pfp and stats
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //pfp
                            Container(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                  padding: const EdgeInsets.all(0),
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image:
                                            AssetImage("assets/images/pfp.png"),
                                        fit: BoxFit.cover),
                                  )),
                            ),
                            //stats
                            SizedBox(
                                width: 270,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //Profile
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 3, right: 3, top: 3),
                                        width: 250,
                                        height: 40,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FirebaseAuth.instance.currentUser
                                                          ?.displayName !=
                                                      null
                                                  ? FirebaseAuth.instance
                                                      .currentUser!.displayName!
                                                  : "ARchive User",
                                              style: (TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.5)),
                                            ),
                                            SizedBox(height: 5),
                                            SizedBox(
                                              height: 15,
                                              child: RichText(
                                                text: TextSpan(
                                                  text:
                                                      "Pronouns • Purdue'28 | ",
                                                  style: (TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white
                                                          .withOpacity(0.5))),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "@purduecs",
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xff93B7BE),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    //Followings
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 3, right: 3, bottom: 3),
                                        width: 250,
                                        height: 75,
                                        decoration: BoxDecoration(
                                          color: Color(0xff202020),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          //posts, followers, followings
                                          children: [
                                            //posts
                                            Container(
                                                margin: const EdgeInsets.all(3),
                                                width: 75,
                                                height: 75,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                        _quotes.length
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text("Quotes",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.5))),
                                                  ],
                                                )),
                                            //followers
                                            Container(
                                                margin: const EdgeInsets.all(3),
                                                width: 75,
                                                height: 75,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text("0",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text("Followers",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 12)),
                                                  ],
                                                )),
                                            //followings
                                            Container(
                                                margin: const EdgeInsets.all(3),
                                                width: 75,
                                                height: 75,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text("0",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text("Following",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 12)),
                                                  ],
                                                )),
                                          ],
                                        ))
                                  ],
                                ))
                          ])),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: BrandButton(
                      onTap: () => {},
                      label: "Edit Profile",
                      type: BrandButtonType.accent,
                    ),
                  ),
                ],
              )),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                  child: GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(CupertinoPageRoute(
                              builder: (context) => const StartPage()));
                    },
                    child: Text("Log Out",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.75))),
                  ))
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text("Your Quote Collection",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 35,
                height: 35,
                child: BrandButton(
                  loading: _loading,
                  onTap: () async {
                    setState(() {
                      _loading = true;
                    });
                    await postService.getPostsById().then(
                      (value) {
                        debugPrint("Got posts: ${value.docs.length}");
                        setState(() {
                          _quotes = value.docs.map((e) => e.data()).toList();
                          _loading = false;
                        });
                      },
                    );
                  },
                  icon: HeroIcon(HeroIcons.arrowPath,
                      size: 20, color: Colors.white),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _quotes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Quote(quote: _quotes[index]),
                  );
                }),
          )
        ])));
  }
}

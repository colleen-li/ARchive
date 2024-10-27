import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:archive/widgets/brand_button.dart';
import 'package:archive/widgets/post_toolbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  bool _liked = false;
  @override
  Widget build(BuildContext context) {
    final viewWidth = MediaQuery.of(context).size.width;
    final viewHeight = MediaQuery.of(context).size.height;

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
                height: 75,
                width: 75,
                fit: BoxFit.contain,)),
            //Profile
            Container(
              width: 380, 
              height: 190,
              decoration: BoxDecoration(
                color: Color(0xff202020),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  //Profile Pic and Stats
                Container(
                    width: 380,
                    height: 145,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    //Split pfp and stats
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //pfp
                        Container(
                          margin: const EdgeInsets.only(left: 0.5, right: 0.5, top: 0.0, bottom: 0.0),
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image : AssetImage("assets/images/pfp.png")),
                          )
                        ),
                        //stats
                        Container(
                          width: 270,
                          height: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Profile
                              Container(
                                margin: const EdgeInsets.only(left: 3, right: 3, top: 3),
                                width: 250,
                                height: 40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "USERNAME",
                                      style: (TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                                    ),
                                    Text(
                                      "Add Pronouns • Purdue'28 | @purduecs",
                                      style: (TextStyle(fontSize:14,color: Colors.white.withOpacity(0.5)))
                                    )
                                  ],
                                )
                              ),
                              //Followings
                              Container(
                                margin: const EdgeInsets.only(left:3, right: 3, bottom: 3),
                                width: 250,
                                height: 75,
                                decoration: BoxDecoration(
                                  color: Color(0xff202020),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //posts, followers, followings
                                  children: [
                                    //posts
                                    Container(
                                      margin: const EdgeInsets.all(3),
                                      width: 75,
                                      height: 75,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("#", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                          Text("Quotes", style: TextStyle(fontSize: 12)),
                                        ],)
                                    ),
                                    //followers
                                    Container(
                                      margin: const EdgeInsets.all(3),
                                      width: 75,
                                      height: 75,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("#", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                          Text("Followers", style: TextStyle(fontSize: 12)),
                                        ],)
                                    ),
                                    //followings
                                    Container(
                                      margin: const EdgeInsets.all(3),
                                      width: 75,
                                      height: 75,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("#", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                          Text("Following", style: TextStyle(fontSize: 12)),
                                        ],)
                                    ),
                                  ],
                                  )
                              )
                            ],
                          )
                        )
                      ]
                    )  
                ),
                Container(
                  width: 350,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0xff785964),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("Follow", style: TextStyle(fontSize: 24, letterSpacing: 1.5), textAlign: TextAlign.center),
                ), 
                ],)
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 10),
              alignment: Alignment.centerLeft,
              child: Text("Your Quote Collection", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
            )
          ]
        )
      ),
    );
  }
}


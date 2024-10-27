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
  @override
  Widget build(BuildContext context) {
    final viewWidth = MediaQuery.of(context).size.width;
    final viewHeight = MediaQuery.of(context).size.height;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          margin: EdgeInsets.all(0),
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
              width: 400, 
              height: 300,
              decoration: BoxDecoration(
                color: Color.fromARGB(0, 203, 114, 114)
              ),
              child: Column(
                margin: EdgeInsets.all(0),
                children: [
                  //Profile Pic and Stats
                Container(
                    width: 380,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    //Split pfp and stats
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //pfp
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 172, 56, 56),
                            borderRadius: BorderRadius.circular(8),
                          )
                        ),
                        //stats
                        Container(
                          width: 270,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Column(
                            margin: EdgeInsets.all(0),
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Profile
                              Container(
                                margin: const EdgeInsets.all(5),
                                width: 250,
                                height: 50,
                                child: Column(
                                  margin: EdgeInsets.all(0),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "USERNAME",
                                      style: (TextStyle(fontWeight: FontWeight.bold,)),
                                    ),
                                    Text(
                                      "Add Pronouns • Purdue'28 | @purduecs",
                                      style: (TextStyle(fontSize:12,color: Colors.white.withOpacity(0.5)))
                                    )
                                  ],
                                )
                              ),
                              //Followings
                              Container(
                                margin: const EdgeInsets.all(8),
                                width: 250,
                                height: 75,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 172, 56, 56),
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
                                        margin: EdgeInsets.all(0),
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
                                        margin: EdgeInsets.all(0),
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("#", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                          Text("Quotes", style: TextStyle(fontSize: 12)),
                                        ],)
                                    ),
                                    //followings
                                    Container(
                                      margin: const EdgeInsets.all(3),
                                      width: 75,
                                      height: 75,
                                      child: Column(
                                        margin: EdgeInsets.all(0),
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("#", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                          Text("Follow", style: TextStyle(fontSize: 12)),
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
                  width: 380,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(146, 48, 119, 218),
                    borderRadius: BorderRadius.circular(8),
                  ),
                )  
                ],)
            ),
          ]
        )
      ),
    );
  }
}


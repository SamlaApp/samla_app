import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class CommunityDetail extends StatelessWidget {
  final int communityID;

  const CommunityDetail({super.key, required this.communityID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: GradientAppBar(context),
      body: Stack(
        children: [
          Positioned(
            child: GradientAppBar(context),
          ),
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: SafeArea(
              child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // main contents
                    SizedBox(
                      height: 80,
                    ),

                    CircleAvatar(
                      backgroundColor: theme_green,
                      radius: 51,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/download.jpeg'),
                        radius: 49,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text('Community Name',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            decoration: TextDecoration.none,
                            color: theme_darkblue.withOpacity(0.95))),

                    SizedBox(height: 5),

                    // community handle
                    Text('@communityhandle',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            decoration: TextDecoration.none,
                            color: theme_darkblue.withOpacity(0.5))),

                    SizedBox(height: 30),

                    // row of number of memebers and public/private
                    MermbersCountWidget(),
                    SizedBox(height: 10),

                    OverViewWidget(),
                    SizedBox(
                      height: 30,
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme_green,
                                   // Replace with your theme_green color
                              theme_pink // Replace with your theme_pink color
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        height: 60,
                        child: TextButton(
                          onPressed: () {},
                          child: Text('JOIN COMMUNITY',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            decoration: TextDecoration.none,
                            color: primary_color.withOpacity(0.95))
                          ),
                          ),
                        ),
                      ),
                    
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

class OverViewWidget extends StatelessWidget {
  const OverViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: primary_decoration,
      child: Column(children: [
        Text('Overview',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                decoration: TextDecoration.none,
                color: theme_darkblue.withOpacity(0.75))),
        SizedBox(height: 10),
        Text(lorem,
            style:
                TextStyle(fontSize: 14, color: theme_darkblue.withOpacity(0.8)))
      ]),
    );
  }
}

class MermbersCountWidget extends StatelessWidget {
  const MermbersCountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
      decoration: primary_decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('180',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      color: theme_green)),
              SizedBox(height: 5),
              Text('Members',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      decoration: TextDecoration.none,
                      color: theme_darkblue.withOpacity(0.5))),
            ],
          ),
          Column(
            children: [
              Text('PUBLIC',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      color: theme_green)),
              SizedBox(height: 5),
              Text('Community',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      decoration: TextDecoration.none,
                      color: theme_darkblue.withOpacity(0.5))),
            ],
          ),
        ],
      ),
    );
  }
}

PreferredSize GradientAppBar(context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(190),
    child: Container(
      height: 190,
      child: AppBar(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        toolbarHeight: 150,
        flexibleSpace: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.bottomLeft,
          secondaryBegin: Alignment.bottomRight,
          secondaryEnd: Alignment.topLeft,
          primaryColors: [
            theme_green,
            Colors.blueAccent,
          ],
          secondaryColors: [
            theme_green,
            // Color.fromARGB(255, 87, 21, 255),
            Color.fromARGB(255, 120, 90, 255)
          ],
        ),
      ),
    ),
  );
}

String lorem =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nisl eget nu Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nisl eget nu Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nisl eget nu Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nisl eget nu';

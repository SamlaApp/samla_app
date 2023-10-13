import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  final String communityName;
  final String communityID;
  const CommunityPage({super.key, required this.communityName, required this.communityID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 150,
        
        backgroundColor: Colors.amber,
      ) ,
      body: Center(
        child: Text('Community Page ${communityName}'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/chatting/presentation/pages/chat.dart';
import 'package:samla_app/features/community/presentation/pages/community.dart';
import 'package:samla_app/features/main/presentation/pages/home.dart';
import 'package:samla_app/features/nutrition/presentation/pages/nutrition.dart';
import 'package:samla_app/features/training/presentation/pages/training.dart';

import 'CustomAppBar.dart';
import 'CustomNavigationBar.dart';

class MainPages extends StatefulWidget {
  const MainPages({super.key});

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int _currentIndex = 2;
  final screens = [
    // for only navigation bar screens
    TrainingPage(),
    NutritionPage(),
    HomePage(),
    CommunityPage(),
    ChattingPage(),
  ];

  void changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary_color,
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(child: screens[_currentIndex]),
        bottomNavigationBar: CustomNavigationBar(
          notifyParent: changePage,
          index: _currentIndex,
        ),
      ),
    );
  }
}

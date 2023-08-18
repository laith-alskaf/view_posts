import 'package:flutter/material.dart';

import '../home_post_view/home_post_view.dart';
class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:Container(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(47, 61, 74, 0),
              Color.fromRGBO(47, 61, 74, 0),
              Color.fromRGBO(47, 61, 74, 0),
              Color.fromRGBO(12, 181, 149, 0.34),
              Color.fromRGBO(12, 181, 149, 0.47),
              Color.fromRGBO(12, 181, 149, 0.47),
              Color.fromRGBO(12, 181, 149, 0.40),
            ],
          ),
        ),
        child: HomePostView(),
      ),
    ));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

import '../sora/sora.dart';

class Splash extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Splash({super.key});
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const Sora()));
    });
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xfffffbe7),
      body: SafeArea(
        child: Center(
          child: Image.asset("assets/images/quran_logo.png"),
        ),
      ),
    );
  }
}

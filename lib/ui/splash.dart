// ignore_for_file: use_build_context_synchronously, await_only_futures

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nasim/addition/createUser.dart';
import 'package:nasim/ui/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nasim/ui/home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () async {
      if (await FirebaseAuth.instance.currentUser != null) {
        buildUser();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LogIn()),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    // context size
    double screenWidth = queryData.size.width;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0xff007088),
    ));

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xff007088),
        body: Center(
          child: Image.asset(
            'assets/logo/شبكة النسيم.png',
            width: screenWidth / 2.8,
          ),
        ),
      ),
    );
  }
}

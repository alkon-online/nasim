import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nasim/ui/home.dart';

import '../addition/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    // context size
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;


    return Scaffold(
      backgroundColor: const Color(0xff007088),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/icons/success.png', width: 100),
          SizedBox(width: screenWidth, height: screenHeight / 45,),
          defultText(
                    text: AppLocalizations.of(context)!.success_title,
                    size: 20,
                    weight: FontWeight.w400),
          SizedBox(height: screenHeight / 120),
          defultText(
                    text: AppLocalizations.of(context)!.success_message,
                    size: 15,
                    color: Colors.white.withAlpha(100), align: TextAlign.center),
        ],
      ),
    );
  }
}
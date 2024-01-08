// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nasim/addition/widgets.dart';
import 'package:nasim/ui/home.dart';
import 'package:pinput/pinput.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    // context size
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    final defaultPinTheme = PinTheme(
      width: screenWidth / 6.5,
      height: screenWidth / 5.5,
      textStyle: GoogleFonts.alexandria(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w500),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.2),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    Widget buildPinPut() {
      return Pinput(
        onCompleted: (pin) => log(pin),
        defaultPinTheme: defaultPinTheme,
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff007088),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 15, vertical: screenHeight / 18),
        child: Column(
          children: [
            //toolbar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    defultText(
                        text: 'Phone Number',
                        size: 24.00,
                        weight: FontWeight.bold),
                    SizedBox(
                      width: screenWidth / 90,
                    ),
                    Image.asset(
                      'assets/icons/User.png',
                      width: 20,
                    ),
                    Expanded(child: SizedBox()),
                    defultText(
                        text: 'ENG',
                        size: screenWidth / 23,
                        color: Color(0xff003C48),
                        weight: FontWeight.bold)
                  ],
                ),
                defultText(
                    text: 'verify your phone number!',
                    size: screenWidth / 26,
                    color: const Color(0xff70AEBC),
                    weight: FontWeight.w400)
              ],
            ),

            SizedBox(
              height: screenHeight / 12.4,
            ),

            Image.asset(
              'assets/logo/شبكة النسيم.png',
              width: screenWidth / 3.5,
            ),

            SizedBox(
              height: screenHeight / 12.4,
            ),

            //otp
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildPinPut(),
                SizedBox(height: screenWidth / 50,),
            defultText(
                    text: 'Did’t recive a code ?',
                    color: Colors.white.withAlpha(150),
                    size: 13.5),
              ],
            ),

            Expanded(child: SizedBox()),
            defultButton(
                text: 'Create Account',
                size: 18.00,
                width: screenWidth,
                onclick: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
                }),
            SizedBox(
              height: screenHeight / 50,
            ),
            InkWell(
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.alexandria(
                      color: Colors.white, fontSize: 13.5),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Wrong Number ? ',
                        style: TextStyle(color: Colors.white.withAlpha(100))),
                    TextSpan(text: 'Back'),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

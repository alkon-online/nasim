// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nasim/addition/change_notifier.dart';
import 'package:nasim/addition/widgets.dart';
import 'package:nasim/ui/auth/signup/about.dart';

import '../../../addition/flutterfire.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController gmail = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    // context size
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

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
                        text: AppLocalizations.of(context)!.create_account,
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
                    TextButton(
                      onPressed: () {
                        Provider.of<LocaleProvider>(context, listen: false)
                            .toggleLocale();
                      },
                      child: defultText(
                          text: AppLocalizations.of(context)!.language,
                          size: screenWidth / 23,
                          color: const Color(0xff003C48),
                          weight: FontWeight.bold),
                    )
                  ],
                ),
                defultText(
                    text: AppLocalizations.of(context)!.welcome,
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

            //form

            defultInput(
                placeholder: AppLocalizations.of(context)!.email,
                controller: gmail),
            SizedBox(height: screenHeight / 65),
            defultInput(
                placeholder: AppLocalizations.of(context)!.password,
                controller: password,
                password: true),
            SizedBox(height: screenHeight / 65),
            defultInput(
                placeholder: AppLocalizations.of(context)!.re_password,
                password: true),
            Expanded(child: SizedBox()),
            defultButton(
                text: AppLocalizations.of(context)!.next,
                size: 18.00,
                width: screenWidth,
                onclick: () async {
                  bool shouldNavigate =
                      await register(gmail.text, password.text);
                  if (shouldNavigate) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const About()),
                    );
                  }
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
                        text: AppLocalizations.of(context)!.registered,
                        style: TextStyle(color: Colors.white.withAlpha(100))),
                    TextSpan(text: AppLocalizations.of(context)!.login),
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

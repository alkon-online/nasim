// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nasim/addition/change_notifier.dart';
import 'package:nasim/addition/widgets.dart';
import 'package:nasim/ui/auth/signup/signup.dart';
import 'package:nasim/ui/language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../addition/flutterfire.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
      backgroundColor: const Color(0xff007088),
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
                        text: AppLocalizations.of(context)!.login,
                        size: 24.00,
                        weight: FontWeight.bold),
                    SizedBox(
                      width: screenWidth / 90,
                    ),
                    Image.asset(
                      'assets/icons/User.png',
                      width: 20,
                    ),
                    const Expanded(child: SizedBox()),
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
                    text: AppLocalizations.of(context)!.welcome_back,
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
            textField(
                  hint: AppLocalizations.of(context)!.email,
                controller: gmail),
            SizedBox(height: 15),
            textField(
                  hint: AppLocalizations.of(context)!.password,
                controller: password,
                password: true),
            const Expanded(child: SizedBox()),
            defultButton(
                text: AppLocalizations.of(context)!.login,
                size: 18.0,
                width: screenWidth,
                onclick: () async {
                  bool shouldNavigate = await signIn(gmail.text, password.text);
                  if (shouldNavigate) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Language()),
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
                        text: AppLocalizations.of(context)!.no_account,
                        style: TextStyle(color: Colors.white.withAlpha(100))),
                    TextSpan(
                        text: AppLocalizations.of(context)!.create_account),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

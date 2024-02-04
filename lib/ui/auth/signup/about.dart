import 'package:flutter/material.dart';
import 'package:nasim/addition/about_user.dart';
import 'package:nasim/addition/change_notifier.dart';
import 'package:nasim/addition/widgets.dart';
import 'package:nasim/ui/language.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

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
                        text: AppLocalizations.of(context)!.about_account,
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
                    text: AppLocalizations.of(context)!.about_user,
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
                  hint: AppLocalizations.of(context)!.name, controller: name),
            SizedBox(height: 15),
            textField(
                  hint: AppLocalizations.of(context)!.phone, controller: phone),
            const Expanded(child: SizedBox()),
            defultButton(
                text: AppLocalizations.of(context)!.next,
                size: 18.00,
                width: screenWidth,
                onclick: () {
                  addUser(name.text, phone.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Language()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

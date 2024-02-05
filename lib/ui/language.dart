import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nasim/addition/change_notifier.dart';
import 'package:nasim/addition/createUser.dart';
import 'package:nasim/addition/widgets.dart';
import 'package:nasim/ui/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    // context size
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    Widget language({name, icon, required String languageCode}) {
      return InkWell(
        child: Row(
          children: [
            Image.asset(
              icon,
              width: screenWidth / 9,
            ),
            SizedBox(
              width: screenWidth / 40,
            ),
            Text(
              name,
              style: GoogleFonts.alexandria(
                  color: Colors.white, fontSize: 20),
            )
          ],
        ),
        onTap: () {
          Provider.of<LocaleProvider>(context, listen: false)
                            .changeLocale(Locale(languageCode));
                            buildUser();
          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xff007088),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth / 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/logo/شبكة النسيم.png',
              width: screenWidth / 3.3,
            ),
            SizedBox(
              height: screenHeight / 12.5,
            ),
            defultText(
                text: AppLocalizations.of(context)!.choose_language,
                weight: FontWeight.bold,
                size: 24.00),
            SizedBox(
              height: screenHeight / 100,
            ),
            defultText(
                text: AppLocalizations.of(context)!.select_language,
                color: Colors.white.withAlpha(100),
                size: 20.00),
            SizedBox(
              height: screenHeight / 12.5,
            ),
            language(name: 'English', icon: 'assets/icons/Great Britain.png', languageCode: "en"),
            Container(
              margin: EdgeInsets.symmetric(vertical: screenHeight / 50),
              width: screenWidth,
              height: 1,
              color: Colors.white.withAlpha(30),
            ),
            language(name: 'العربية', icon: 'assets/icons/Saudi Arabia.png', languageCode: "ar")
          ],
        ),
      ),
    );
  }
}

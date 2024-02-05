// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nasim/addition/createUser.dart';
import 'package:nasim/addition/dialog.dart';
import 'package:nasim/addition/flutterfire.dart';
import 'package:nasim/addition/widgets.dart';
import 'package:nasim/ui/maintenance.dart';
import 'package:nasim/ui/notifications.dart';
import 'package:nasim/ui/plan.dart';
import 'package:nasim/ui/splash.dart';
import 'package:simple_shadow/simple_shadow.dart';

import 'order/my_orders.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    // context size
    double screenWidth = queryData.size.width;
    // document instance
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Widget option({image, name, info, onPressed}) {
      return SizedBox(
        width: screenWidth / 1.5,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0xff005062),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Set border radius
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                image,
                height: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              defultText(text: name, size: 20, weight: FontWeight.bold),
              const SizedBox(
                height: 5,
              ),
              defultText(
                  text: info,
                  size: 14,
                  color: Colors.white.withAlpha(150),
                  maxlines: 2)
            ],
          ),
        ),
      );
    }
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: const Color(0xff007088),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // toolbar
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth / 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Image.asset(
                            'assets/icons/nav.png',
                            width: 20,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Orders()),
                            );
                          },
                        ),
                        FutureBuilder<DocumentSnapshot>(
                          future: users.doc(CurrentUser.uid).get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                  child: defultText(
                                      text:
                                          AppLocalizations.of(context)!.welcome,
                                      weight: FontWeight.w600,
                                      size: 20));
                            }

                            if (snapshot.hasData && !snapshot.data!.exists) {
                              return Center(
                                  child: defultText(
                                      text:
                                          AppLocalizations.of(context)!.welcome,
                                      weight: FontWeight.w600,
                                      size: 20));
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> user =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              CurrentUser.username = user['name'];
                              return defultText(
                                  text: user['name'],
                                  weight: FontWeight.w600,
                                  size: 20);
                            }

                            return Center(
                                child: defultText(
                                    text: "مرحباً..",
                                    weight: FontWeight.w600,
                                    size: 20));
                          },
                        ),
                        InkWell(
                          child: Image.asset(
                            'assets/icons/bell.png',
                            width: 20,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Notifications()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  SimpleShadow(
                    opacity: 0.4, // Default: 0.5
                    color: Colors.black, // Default: Black
                    offset: const Offset(5, 25), // Default: Offset(2, 2)
                    sigma: 15,
                    child: Image.asset(
                      'assets/logo/شبكة النسيم.png',
                      width: screenWidth / 2.7,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: screenWidth / 14,
                          ),
                          option(
                              image: 'assets/icons/Tools.png',
                              name: AppLocalizations.of(context)!
                                  .maintenance_request,
                              info: AppLocalizations.of(context)!
                                  .maintenance_description,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) =>
                                          const Maintenance()),
                                );
                              }),
                          const SizedBox(
                            width: 20,
                          ),
                          option(
                              image: 'assets/icons/Installing Updates.png',
                              name: AppLocalizations.of(context)!
                                  .installation_request,
                              info: AppLocalizations.of(context)!
                                  .installation_description,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) =>
                                          const Plan()),
                                );
                              }),
                          const SizedBox(
                            width: 20,
                          ),
                          option(
                              image: 'assets/icons/Upload.png',
                              name: AppLocalizations.of(context)!.signout,
                              info: AppLocalizations.of(context)!
                                  .signout_description,
                              onPressed: () {
                                showAlertDialog(context,
                                    title:
                                        AppLocalizations.of(context)!.signout,
                                    content: AppLocalizations.of(context)!
                                        .signout_description, onOk: () async {
                                  bool shouldNavigate = await signOut();
                                  if (shouldNavigate) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Splash()),
                                    );
                                  }
                                });
                              }),
                          const SizedBox(
                            width: 20,
                          ),
                          option(
                              image: 'assets/icons/User.png',
                              name:
                                  AppLocalizations.of(context)!.delete_request,
                              info: AppLocalizations.of(context)!
                                  .delete_description,
                              onPressed: () {
                                showAlertDialog(context,
                                    title: AppLocalizations.of(context)!
                                        .delete_request,
                                    content: AppLocalizations.of(context)!
                                        .delete_description, onOk: () async {
                                  bool shouldNavigate = await signOut();
                                  if (shouldNavigate) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Splash()),
                                    );
                                  }
                                });
                              }),
                          SizedBox(
                            width: screenWidth / 14,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

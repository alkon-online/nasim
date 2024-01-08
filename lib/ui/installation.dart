import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:nasim/ui/plan.dart';

import '../addition/userLocation.dart';
import '../addition/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Installation extends StatefulWidget {
  const Installation({Key? key}) : super(key: key);

  @override
  State<Installation> createState() => _InstallationState();
}

class _InstallationState extends State<Installation> {
  TextEditingController phone = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    try {
      List<Placemark> placemark =
          await placemarkFromCoordinates(UserLocation.lat, UserLocation.long);

      setState(() {
        UserLocation.city = placemark[0].locality!;
        UserLocation.street = placemark[0].street!;
        UserLocation.subLocality = placemark[0].subLocality!;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    // context size
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    // Widget upload() {
    //   return Container(
    //       height: screenWidth / 4.2,
    //       width: screenWidth,
    //       decoration: BoxDecoration(
    //           border: Border.all(color: Colors.white, width: 1),
    //           borderRadius: BorderRadius.circular(10)),
    //       child: Center(
    //           child: Image.asset(
    //         'assets/icons/Upload.png',
    //         width: screenWidth / 8.5,
    //       )));
    // }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff007088),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: screenWidth / 14, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // toolbar
              Row(
                children: [
                  const BackButton(color: Colors.white),
                  const SizedBox(
                    width: 18.00,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defultText(
                          text: AppLocalizations.of(context)!.installation,
                          weight: FontWeight.w600,
                          size: 18.00),
                      SizedBox(height: screenWidth / 100),
                      defultText(
                          text: AppLocalizations.of(context)!
                              .request_installation,
                          color: Colors.white.withAlpha(100),
                          size: 13.5)
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight / 16,
              ),
              // text info
              SizedBox(
                  width: screenWidth / 1.5,
                  child: defultText(
                      text: AppLocalizations.of(context)!.enter_informations,
                      size: 20,
                      weight: FontWeight.w600)),

              SizedBox(
                height: screenHeight / 40,
              ),

              defultInput(
                  placeholder: AppLocalizations.of(context)!.phone,
                  controller: phone),
              SizedBox(
                height: screenHeight / 65,
              ),

              defultInput(
                  placeholder: AppLocalizations.of(context)!.notes,
                  controller: note),
              SizedBox(
                height: screenHeight / 20,
              ),

              // location info
              defultText(
                  text: AppLocalizations.of(context)!.location,
                  size: 20,
                  weight: FontWeight.w600),
              SizedBox(
                height: screenHeight / 80,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/Home Address.png',
                    width: 15,
                  ),
                  SizedBox(
                    width: screenWidth / 50,
                  ),
                  defultText(
                    text: '${UserLocation.city}, ${UserLocation.subLocality}',
                    size: screenWidth / 22,
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              defultButton(
                  text: AppLocalizations.of(context)!.next,
                  size: 18.00,
                  width: screenWidth,
                  onclick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Plan(phone: phone.text, notes: note.text)),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

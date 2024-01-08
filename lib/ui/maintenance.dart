import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:nasim/addition/request_maintenance.dart';
import 'package:nasim/addition/userLocation.dart';
import 'package:nasim/addition/widgets.dart';
import 'package:nasim/ui/home.dart';
import 'package:nasim/ui/success.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Maintenance extends StatefulWidget {
  const Maintenance({Key? key}) : super(key: key);

  @override
  State<Maintenance> createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
  TextEditingController phone = TextEditingController();
  TextEditingController info = TextEditingController();

  String reason = 'cuts out';

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
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth / 14, vertical: 20),
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
                          text: AppLocalizations.of(context)!.maintenance,
                          weight: FontWeight.w600,
                          size: 18.00),
                      SizedBox(height: screenWidth / 100),
                      defultText(
                          text: AppLocalizations.of(context)!.request_maintenance,
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
              defultInput(placeholder: AppLocalizations.of(context)!.phone, controller: phone),
              SizedBox(
                height: screenHeight / 65,
              ),

              defultInput(
                placeholder: AppLocalizations.of(context)!.describe,
                controller: info,
              ),
              SizedBox(
                height: screenHeight / 80,
              ),
              RadioListTile(
                activeColor: Colors.white,
                title: defultText(
                    text: AppLocalizations.of(context)!.cuts_out,
                    color: Colors.white,
                    size: 16),
                value: "cuts out",
                groupValue: reason,
                onChanged: (value) {
                  setState(() {
                    reason = value.toString();
                  });
                },
              ),
              RadioListTile(
                activeColor: Colors.white,
                title: defultText(
                    text: AppLocalizations.of(context)!.not_working,
                    color: Colors.white,
                    size: 16),
                value: "not working",
                groupValue: reason,
                onChanged: (value) {
                  setState(() {
                    reason = value.toString();
                  });
                },
              ),
              RadioListTile(
                activeColor: Colors.white,
                title: defultText(
                    text: AppLocalizations.of(context)!.slow,
                    color: Colors.white,
                    size: 16),
                value: "slow connection",
                groupValue: reason,
                onChanged: (value) {
                  setState(() {
                    reason = value.toString();
                  });
                },
              ),

              SizedBox(
                height: screenHeight / 65,
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

              // upload info
              // defultText(
              //     text: 'Upload image',
              //     size: 20,
              //     weight: FontWeight.w600),
              // SizedBox(
              //   height: screenHeight / 40,
              // ),
              // upload(),
              const Expanded(child: SizedBox()),
              defultButton(
                  text: AppLocalizations.of(context)!.send_request,
                  size: 18.00,
                  width: screenWidth,
                  onclick: () async {
                    //   var response = await MyFatoorah.startPayment(
                    //   context: context,
                    //   request: MyfatoorahRequest.test(
                    //     currencyIso: Country.SaudiArabia,
                    //     customerName: 'NASIM',
                    //     successUrl: 'https://www.facebook.com',
                    //     errorUrl: 'https://www.google.com/',
                    //     invoiceAmount: 200,
                    //     language: ApiLanguage.English,
                    //     token:
                    //     'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
                    //   ),
                    // );
                    // log(response.paymentId.toString());
                    // log(response.status.toString());

                    //if(response.isSuccess){
                    DateTime now = DateTime.now();
                    String formattedDate =
                        DateFormat('yyyy-MM-dd – kk:mm').format(now);
                    requestMaintenance(Home.name, phone.text, info.text, reason,
                        UserLocation.lat, UserLocation.long, formattedDate);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Success()),
                    );
                    //}
                  })
            ],
          ),
        ),
      ),
    );
  }
}

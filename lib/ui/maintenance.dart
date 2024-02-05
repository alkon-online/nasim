import 'package:flutter/material.dart';
import 'package:nasim/addition/createUser.dart';
import 'package:nasim/addition/get.dart';
import 'package:nasim/addition/sendOrder.dart';
import 'package:nasim/addition/widgets.dart';
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

  String selectedLocality = "";
  List<String> localitiesList = [];

  String selectedSubLocality = "";
  List<String> subLocalitiesList = [];

  @override
  void initState() {
    super.initState();
    getSupportedLocalities().then((localities) {
      setState(() {
        localitiesList = localities;
        selectedLocality = localities.first;
      });
      getSupportedSubLocalities().then((subLocalities) {
        setState(() {
          subLocalitiesList = subLocalities;
          selectedSubLocality = subLocalities.first;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    // context size
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    String selectedIssue = AppLocalizations.of(context)!.cuts_out;
    List<String> issuesList = [
      AppLocalizations.of(context)!.cuts_out,
      AppLocalizations.of(context)!.not_working,
      AppLocalizations.of(context)!.slow
    ];

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
                          text: AppLocalizations.of(context)!.maintenance,
                          weight: FontWeight.w600,
                          size: 18.00),
                      SizedBox(height: screenWidth / 100),
                      defultText(
                          text:
                              AppLocalizations.of(context)!.request_maintenance,
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
                height: 20,
              ),
              textField(
                  hint: AppLocalizations.of(context)!.phone, controller: phone),
              SizedBox(
                height: 15,
              ),

              textField(
                hint: AppLocalizations.of(context)!.describe,
                controller: info,
              ),
              SizedBox(
                height: screenHeight / 80,
              ),

              dropDown(
                  value: selectedIssue,
                  items: issuesList,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedIssue = newValue!;
                    });
                  }),
              SizedBox(
                height: screenHeight / 80,
              ),

              dropDown(
                  value: selectedLocality,
                  items: localitiesList,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLocality = newValue!;
                    });
                  }),
              SizedBox(
                height: screenHeight / 80,
              ),

              dropDown(
                  value: selectedSubLocality,
                  items: subLocalitiesList,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSubLocality = newValue!;
                    });
                  }),
              SizedBox(
                height: screenHeight / 80,
              ),

              // upload info
              // defultText(
              //     text: 'Upload image',
              //     size: 20,
              //     weight: FontWeight.w600),
              // SizedBox(
              //   height: 20,
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
                    sendOrder(
                            username: CurrentUser.username,
                            phone: phone.text,
                            orderType: "maintenance",
                            notes: info.text,
                            locality: selectedLocality,
                            subLocality: selectedSubLocality,
                            issue: selectedIssue)
                        .then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Success()),
                      );
                    });
                    //}
                  })
            ],
          ),
        ),
      ),
    );
  }
}

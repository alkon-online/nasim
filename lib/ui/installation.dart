import 'package:flutter/material.dart';
import 'package:nasim/addition/createUser.dart';
import 'package:nasim/addition/get.dart';
import 'package:nasim/addition/sendOrder.dart';
import 'package:nasim/ui/success.dart';
import '../addition/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Installation extends StatefulWidget {
  final PlanItem plan;
  const Installation({Key? key, required this.plan}) : super(key: key);

  @override
  State<Installation> createState() => _InstallationState();
}

class _InstallationState extends State<Installation> {
  TextEditingController phone = TextEditingController();
  TextEditingController notes = TextEditingController();
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
                height: 20,
              ),

              textField(
                  hint: AppLocalizations.of(context)!.phone, controller: phone),
              SizedBox(
                height: 15,
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

              textField(
                  hint: AppLocalizations.of(context)!.notes, controller: notes),
              const Expanded(child: SizedBox()),
              defultButton(
                  text: AppLocalizations.of(context)!.next,
                  size: 18.00,
                  width: screenWidth,
                  onclick: () {
                    sendOrder(
                            username: CurrentUser.username,
                            phone: phone.text,
                            orderType: "installation",
                            notes: notes.text,
                            locality: selectedLocality,
                            subLocality: selectedSubLocality,
                            plan: widget.plan)
                        .then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Success()),
                      );
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

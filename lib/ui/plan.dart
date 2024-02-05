import 'package:flutter/material.dart';
import 'package:nasim/addition/get.dart';
import 'package:nasim/addition/sendOrder.dart';
import 'package:nasim/addition/widgets.dart';
import 'package:nasim/ui/installation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
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

    Widget plan({name, price, description}) {
      return InkWell(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.white.withOpacity(0.2), width: 1))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defultText(
                          text: name,
                          size: screenWidth / 25,
                          weight: FontWeight.w600),
                      defultText(
                          text: "${price}SR",
                          size: screenWidth / 22,
                          color: Colors.white.withOpacity(0.8))
                    ],
                  ),
                  const Icon(Icons.chevron_right_rounded, color: Colors.white)
                ],
              ),
              const SizedBox(height: 5),
              defultText(
                  text: description,
                  size: screenWidth / 30,
                  color: Colors.white.withOpacity(0.5))
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Installation(
                    plan: PlanItem(
                        label: name, description: description, price: double.parse(price)))),
          );
        },
      );
    }

    return Scaffold(
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
                          text: AppLocalizations.of(context)!.plan,
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
                      text: AppLocalizations.of(context)!.choose_plan,
                      size: 20,
                      weight: FontWeight.w600)),

              SizedBox(
                height: screenHeight / 30,
              ),
              plan(
                  name: AppLocalizations.of(context)!.basic,
                  price: "600",
                  description: "7MB: 100SR + Installation: 500SR"),
              plan(
                  name: AppLocalizations.of(context)!.plus,
                  price: "650",
                  description: "10MB: 150SR + Installation: 500SR"),
              plan(
                  name: AppLocalizations.of(context)!.ultimate,
                  price: "700",
                  description: "15MB: 200SR + Installation: 500SR")
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../addition/gmail.dart';
import '../../addition/request_maintenance.dart';
import '../../addition/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaintenanceOrder extends StatefulWidget {
  const MaintenanceOrder({Key? key}) : super(key: key);

  @override
  State<MaintenanceOrder> createState() => _MaintenanceOrderState();
}

class _MaintenanceOrderState extends State<MaintenanceOrder> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    // context size
    double screenWidth = queryData.size.width;

    Stream<List<MaintenanceClass>> maintenance() => FirebaseFirestore.instance
        .collection('maintenance')
        .where('gmail', isEqualTo: uid)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => MaintenanceClass.fromJson(doc.data())).toList());

    Widget buildMaintenance(MaintenanceClass maintenance){
      return Container(
          padding: EdgeInsets.symmetric(vertical: screenWidth / 50),
          decoration: BoxDecoration(
            color: const Color(0xff007088),
            border: Border(bottom: BorderSide(color: Colors.white.withAlpha(100)))
          ),
          child: ListTile(
              leading: Image.asset('assets/icons/Toolss.png', color: Colors.white, width: screenWidth / 10),
            title: defultText(text: maintenance.reason, weight: FontWeight.w600, size: 18.00, color: Colors.white),
            subtitle: defultText(text: maintenance.date, size: 13.5, color: Colors.white.withAlpha(100)),
            trailing: Container(
              decoration: BoxDecoration(
              color: maintenance.success == true ? Colors.green : Colors.yellow,
              borderRadius: BorderRadius.circular(100)
              ),
              width: screenWidth / 25,
              height: screenWidth / 25,
            ),
          ),
        );
    }

    return Scaffold(
        backgroundColor: const Color(0xff007088),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth / 14, vertical: screenWidth / 9),
        child: Column(
            children: [
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
                    SizedBox(height: screenWidth / 80),
                    defultText(
                        text: AppLocalizations.of(context)!.your_maintenances,
                        color: Colors.white.withAlpha(100),
                        size: 13.5)
                  ],
                ),
              ],
            ),
            StreamBuilder<List<MaintenanceClass>>(
        stream: maintenance(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return defultText(
                        text: AppLocalizations.of(context)!.error,
                        color: Colors.white,
                        size: 13.5);
          } else if(snapshot.hasData){
            final list = snapshot.data!;
            // books list
            return Expanded(
              child: ListView(
                children: list.map(buildMaintenance).toList(),
              ),
            );
          } else{
            return const Center(child: CircularProgressIndicator(color: Colors.white),);
          }
        },
      )
            ],
          ),
        ),
    );
  }
}
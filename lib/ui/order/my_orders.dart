import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nasim/addition/sendOrder.dart';
import 'package:nasim/ui/home.dart';

import '../../addition/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    // context size
    double screenWidth = queryData.size.width;

    
    Stream<List<OrderClass>> orders() => FirebaseFirestore.instance
        .collection('orders')
        .where('gmail', isEqualTo: Home.gmail)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => OrderClass.fromJson(doc.data())).toList());

    Widget buildMaintenance(OrderClass order){
      return InkWell(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: screenWidth / 50),
            decoration: BoxDecoration(
              color: Color(0xff007088),
              border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.5)))
            ),
            child: ListTile(
              title: defultText(text: order.type, weight: FontWeight.w600, size: 18.00, color: Colors.white),
              subtitle: defultText(text: order.notes, size: 13.5, color: Colors.white.withOpacity(0.7)),
              
            trailing: Container(
              decoration: BoxDecoration(
              color: order.success == true ? Colors.green : Colors.yellow,
              borderRadius: BorderRadius.circular(100)
              ),
              width: screenWidth / 25,
              height: screenWidth / 25,
            ),
            ),
          ),
      );
    }

     return Scaffold(
        backgroundColor: Color(0xff007088),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth / 14, vertical: screenWidth / 9),
        child: Column(
            children: [
              Row(
              children: [
                const BackButton(color: Colors.white),
                SizedBox(
                  width: 18.00,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defultText(
                        text: AppLocalizations.of(context)!.orders,
                        weight: FontWeight.w600,
                        size: 18.00),
                    SizedBox(height: screenWidth / 80),
                    defultText(
                        text: AppLocalizations.of(context)!.your_orders,
                        color: Colors.white.withAlpha(100),
                        size: 13.5)
                  ],
                ),
              ],
            ),
            StreamBuilder<List<OrderClass>>(
        stream: orders(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            log(snapshot.error.toString());
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

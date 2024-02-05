import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nasim/addition/createUser.dart';
import 'package:nasim/addition/user_notification.dart';

import '../addition/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    // context size
    double screenWidth = queryData.size.width;
        
    Stream<List<NotificationClass>> notifications() => FirebaseFirestore.instance
        .collection('users')
        .doc(CurrentUser.uid)
        .collection('notifications')
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => NotificationClass.fromJson(doc.data())).toList());


    Widget notification(NotificationClass notification){
      return Column(
        children: [

         const SizedBox(height: 18.00,),
          Row(
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: const Color(0xff11D4FF),
                        borderRadius: BorderRadius.circular(100)
                      ),
                    ),
                    SizedBox(width: screenWidth / 14),
                    SizedBox(width: screenWidth / 1.4,child: defultText(text: notification.message, size: screenWidth / 23)),
                  ],
                ),
                const SizedBox(height: 18.00,),
                Container(
                  width: screenWidth,
                  height: 0.8,
                  color: Colors.white.withAlpha(100),
                )
        ],
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
                        text: AppLocalizations.of(context)!.notifications,
                        weight: FontWeight.w600,
                        size: 18.00),
                    SizedBox(height: screenWidth / 80),
                    defultText(
                        text: AppLocalizations.of(context)!.your_notifications,
                        color: Colors.white.withAlpha(100),
                        size: 13.5)
                  ],
                ),
              ],
            ),
            StreamBuilder<List<NotificationClass>>(
        stream: notifications(),
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
                children: list.map(notification).toList(),
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
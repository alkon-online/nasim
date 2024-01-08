// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';


//write book
Future postNotification(message, user) async {

  // Reference the document
  final docNotification = FirebaseFirestore.instance.collection('users').doc(user).collection('notifications').doc();

  final notification = NotificationClass(
    message: message,
    time: Timestamp.now()
  );

  final json = notification.toJson();

  await docNotification.set(json);
}

class NotificationClass {
  String message;
  Timestamp time;

  NotificationClass({
    required this.message,
    required this.time
  });

  // to JSON
  Map<String, dynamic> toJson() => {
        'message': message,
        'time': time
      };

  // from json
  static NotificationClass fromJson(Map<String, dynamic> json) =>
      NotificationClass(message: json['message'], time: json['time']);
}
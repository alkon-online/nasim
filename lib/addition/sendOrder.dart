import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nasim/ui/home.dart';

//write book
Future sendOrder(name, phone, type, notes, locality, subLocality,
    {plan, issue}) async {
  // Reference the document
  final docInstallation = FirebaseFirestore.instance.collection('orders').doc();

  final Installation = OrderClass(
      name: name,
      phone: phone,
      type: type,
      gmail: Home.gmail,
      notes: notes,
      success: false,
      locality: locality,
      subLocality: subLocality,
      date: Timestamp.now(),
      plan: plan,
      issue: issue);

  final json = Installation.toJson();

  await docInstallation.set(json);
}

class OrderClass {
  String name;
  String phone;
  String type;
  String? gmail;
  bool? success;
  String notes;
  String locality;
  String subLocality;
  Timestamp? date;
  List? plan;
  String? issue;

  OrderClass(
      {required this.name,
      required this.phone,
      required this.type,
      gmail,
      success,
      required this.notes,
      required this.locality,
      required this.subLocality,
      date,
      plan,
      issue});

  // to JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'gmail': gmail,
        'type': type,
        'success': success,
        'notes': notes,
        'locality': locality,
        'subLocality': subLocality,
        'date': date,
        'plan': plan,
        'issue': issue
      };

  // from json
  static OrderClass fromJson(Map<String, dynamic> json) => OrderClass(
      name: json['name'],
      phone: json['phone'],
      type: json['type'],
      gmail: json['gmail'],
      success: json['success'],
      notes: json['notes'],
      locality: json['locality'],
      subLocality: json['subLocality'],
      date: json['date'],
      plan: json['plan'],
      issue: json['issue']);
}

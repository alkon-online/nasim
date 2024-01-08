import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nasim/ui/home.dart';

//write book
Future requestInstallation(name, phone, notes, lat, long, date, plan) async {
  // Reference the document
  final docInstallation =
      FirebaseFirestore.instance.collection('installation').doc(name + phone);

  final installation = InstallationClass(
      name: name,
      phone: phone,
      gmail: Home.gmail,
      notes: notes,
      success: false,
      lat: lat,
      long: long,
      date: date,
      plan: plan);

  final json = installation.toJson();

  await docInstallation.set(json);
}

class InstallationClass {
  String name;
  String phone;
  String gmail;
  bool success;
  String notes;
  double lat;
  double long;
  String date;
  List plan;

  InstallationClass({
    required this.name,
    required this.phone,
    required this.gmail,
    required this.success,
    required this.notes,
    required this.lat,
    required this.long,
    required this.date,
    required this.plan,
  });

  // to JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'gmail': gmail,
        'success': success,
        'notes': notes,
        'lat': lat,
        'long': long,
        'date': date,
        'plan': plan
      };

  // from json
  static InstallationClass fromJson(Map<String, dynamic> json) =>
      InstallationClass(
          name: json['name'],
          phone: json['phone'],
          gmail: json['gmail'],
          success: json['success'],
          notes: json['notes'],
          lat: json['lat'],
          long: json['long'],
          date: json['date'],
          plan: json['plan']);
}

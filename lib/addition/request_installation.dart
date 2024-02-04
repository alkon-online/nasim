import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nasim/ui/home.dart';

//write book
Future requestInstallation(name, phone, notes, locality, subLocality, date, plan) async {
  // Reference the document
  final docInstallation =
      FirebaseFirestore.instance.collection('Installation').doc(name + phone);

  final Installation = InstallationClass(
      name: name,
      phone: phone,
      gmail: Home.gmail,
      notes: notes,
      success: false,
      locality: locality,
      subLocality: subLocality,
      date: date,
      plan: plan);

  final json = Installation.toJson();

  await docInstallation.set(json);
}

class InstallationClass {
  String name;
  String phone;
  String gmail;
  bool success;
  String notes;
  double locality;
  double subLocality;
  String date;
  List plan;

  InstallationClass({
    required this.name,
    required this.phone,
    required this.gmail,
    required this.success,
    required this.notes,
    required this.locality,
    required this.subLocality,
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
        'locality': locality,
        'subLocality': subLocality,
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
          locality: json['locality'],
          subLocality: json['subLocality'],
          date: json['date'],
          plan: json['plan']);
}

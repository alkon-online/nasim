import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nasim/ui/home.dart';

//write book
Future requestMaintenance(name, phone, info, reason, lat, long, date) async {

  // Reference the document
  final docMaintenance = FirebaseFirestore.instance.collection('maintenance').doc(name+phone);

  final maintenance = MaintenanceClass(
    name: name,
    phone: phone,
    gmail: Home.gmail,
    info: info,
    reason: reason,
    success: false,
    lat: lat,
    long: long,
    date: date
  );

  final json = maintenance.toJson();

  await docMaintenance.set(json);
}

class MaintenanceClass {
  String name;
  String phone;
  String gmail;
  String info;
  String reason;
  bool success;
  double lat;
  double long;
  String date;

  MaintenanceClass({
    required this.name,
    required this.phone,
    required this.gmail,
    required this.info,
    required this.reason,
    required this.success,
    required this.lat,
    required this.long,
    required this.date
  });

  // to JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'gmail': gmail,
        'info': info,
        'reason': reason,
        'success': success,
        'lat': lat,
        'long': long,
        'date': date
      };

  // from json
  static MaintenanceClass fromJson(Map<String, dynamic> json) =>
      MaintenanceClass(name: json['name'], phone: json['phone'], gmail: json['gmail'], info: json['info'], reason: json['reason'], success: json['success'], lat: json['lat'], long: json['long'], date: json['date']);
}
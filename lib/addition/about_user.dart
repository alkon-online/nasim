import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nasim/addition/gmail.dart';

//write book
Future addUser(name, phone) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);

  final user = UserClass(
    name: name,
    gmail: uid,
    phone: phone
  );

  final json = user.toJson();

  await docUser.set(json);
}

class UserClass {
  String name;
  String? gmail;
  String phone;

  UserClass({
    required this.name,
    required this.gmail,
    required this.phone
  });

  // to JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'gmail': gmail,
        'phone': phone
      };

  // from json
  static UserClass fromJson(Map<String, dynamic> json) =>
      UserClass(name: json['name'], gmail: json['gmail'], phone: json['phone']);
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//write book
Future createUser(name, phone) async {
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  User currentUser = await FirebaseAuth.instance.currentUser!;
  final user = UserClass(name: name, email: currentUser.email, phone: phone);

  final json = user.toJson();

  await docUser.set(json);
}

class UserClass {
  String name;
  String? email;
  String phone;

  UserClass({required this.name, required this.email, required this.phone});

  // to JSON
  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'phone': phone};

  // from json
  static UserClass fromJson(Map<String, dynamic> json) =>
      UserClass(name: json['name'], email: json['email'], phone: json['phone']);
}

class CurrentUser {
  static String username = "";
  static String email = "";
  static String uid = "";
}

Future buildUser() async {
  User? user = await FirebaseAuth.instance.currentUser!;
  CurrentUser.email = user.email ?? "";
  CurrentUser.uid = user.uid;
}

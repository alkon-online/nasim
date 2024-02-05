import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nasim/addition/createUser.dart';

//write book
Future sendOrder(
    {username,
    phone,
    orderType,
    notes,
    locality,
    subLocality,
    plan,
    issue}) async {
  // Reference the document
  final docOrders = FirebaseFirestore.instance.collection('orders').doc();

  final Order = OrderClass(
      username: username,
      phone: phone,
      orderType: orderType,
      orderOwner: CurrentUser.uid,
      notes: notes,
      success: false,
      locality: locality,
      subLocality: subLocality,
      createdAt: Timestamp.now(),
      plan: plan ?? PlanItem(label: "", description: "", price: 0),
      issue: issue ?? "");

  final json = Order.toJson();

  await docOrders.set(json);
}

class OrderClass {
  String username;
  String phone;
  String orderType;
  String orderOwner;
  bool success;
  String notes;
  String locality;
  String subLocality;
  Timestamp createdAt;
  PlanItem plan;
  String issue;

  OrderClass(
      {required this.username,
      required this.phone,
      required this.orderType,
      required this.orderOwner,
      required this.success,
      required this.notes,
      required this.locality,
      required this.subLocality,
      required this.createdAt,
      required this.plan,
      required this.issue});

  // to JSON
  Map<String, dynamic> toJson() => {
        'username': username,
        'phone': phone,
        'orderOwner': orderOwner,
        'orderType': orderType,
        'success': success,
        'notes': notes,
        'locality': locality,
        'subLocality': subLocality,
        'createdAt': createdAt,
        'plan': plan.toJson(),
        'issue': issue
      };

  // from json
  static OrderClass fromJson(Map<String, dynamic> json) => OrderClass(
      username: json['username'],
      phone: json['phone'],
      orderType: json['orderType'],
      orderOwner: json['orderOwner'],
      success: json['success'],
      notes: json['notes'],
      locality: json['locality'],
      subLocality: json['subLocality'],
      createdAt: json['createdAt'],
      plan: PlanItem.fromJson(json['plan']),
      issue: json['issue']);
}

class PlanItem {
  String label;
  String description;
  double price;

  PlanItem(
      {required this.label, required this.description, required this.price});

  // to JSON
  Map<String, dynamic> toJson() =>
      {'label': label, 'description': description, 'price': price};

  static PlanItem fromJson(Map<String, dynamic> json) => PlanItem(
      label: json['label'],
      description: json['description'],
      price: json['price']);
}

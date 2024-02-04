import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> getSupportedLocalities() async {
  try {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection("localities").get();
    final List<DocumentSnapshot> documents = result.docs;

    List<String> myListString = [];

    for (var snapshot in documents) {
      myListString.add(snapshot.id);
    }
    return myListString;
  } catch (e) {
    return [];
  }
}
Future<List<String>> getSupportedSubLocalities() async {
  try {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection("sub localities").get();
    final List<DocumentSnapshot> documents = result.docs;

    List<String> myListString = [];

    for (var snapshot in documents) {
      myListString.add(snapshot.id);
    }
    return myListString;
  } catch (e) {
    return [];
  }
}
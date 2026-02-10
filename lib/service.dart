import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> addstudent(
  String name,
  String email,
  String course,
  BuildContext context,
) async {
  await FirebaseFirestore.instance.collection("students").add({
    "name": name,
    "email": email,
    "course": course,
  });
  Navigator.pop(context);
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text("Student Added Successfully")));
}

Stream<QuerySnapshot> getstudents() {
  return FirebaseFirestore.instance.collection("students").snapshots();
}

Future<void> deletestudent(String id, BuildContext context) async {
  await FirebaseFirestore.instance.collection("students").doc(id).delete();
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text("Student deleted Successfully")));
}

Future<void> updatestudent(
  String id,
  String name,
  String email,
  String course,
  BuildContext context,
) async {
  await FirebaseFirestore.instance.collection("students").doc(id).update({
    "name": name,
    "email": email,
    "course": course,
  });
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text("Student updated Successfully")));
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DbFirestore {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  fetchNotes() {
    try {
      return firestore.collection('Notes').snapshots();
    } catch (e) {
      print('from catch..$e');
    }
  }

  static writeNotes(String color,
      {required String title,
      required String desc,
      required String date,
      required String time}) {
    try {
      return firestore.collection('Notes').add({
        "title": title,
        "description": desc,
        "pinned": true,
        "date": date,
        "time": time,
        "color": color == "Color(0xffffffff)" ? Colors.blue.toString() : color
      });
    } catch (e) {
      print('Problem is $e');
    }
  }

  //update
  updateNote(
      {required String docId,
      required String title,
      required String description}) {
    try {
      return firestore
          .collection('Notes')
          .doc(docId)
          .update({"title": title, "description": description});
    } catch (e) {
      print('$e');
    }
  }

  //delete
  deleteNote({required String docId}) {
    try {
      return firestore.collection('Notes').doc(docId).delete();
    } catch (e) {
      print('$e');
    }
  }
}

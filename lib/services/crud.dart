import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  addPhoneNumber(phnData) async {
    Firestore.instance
        .collection('users')
        .add(phnData)
        .catchError((e) => print(e));
  }

  updatePhoneNumber(selectedDoc, newValue) async {
    Firestore.instance
        .collection('users')
        .document(selectedDoc)
        .updateData(newValue)
        .catchError((e) => print(e));
  }

  getPhoneNumber(String phnNumber) {
    return Firestore.instance
        .collection('users')
        .where('phone_number', isEqualTo: phnNumber)
        .getDocuments();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FireService {

  static final FireService _fireService = FireService.internal();
  factory FireService() => _fireService;
  FireService.internal();

  deleteDoc(DocumentReference reference) async {
    await reference!.delete();
  }

  deleteDocById(String path, String id) async {
    await FirebaseFirestore.instance.collection(path).doc(id).delete();
  }

  updateDoc(DocumentReference reference, Map<String, dynamic> json) async {
    await reference!.update(json);
  }

  updateDocById(String path, String id, Map<String, dynamic> json) async {
    await FirebaseFirestore.instance.collection(path).doc(id).update(json);
  }

}
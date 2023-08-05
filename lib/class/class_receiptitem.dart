import 'package:cloud_firestore/cloud_firestore.dart';

class ReceiptItem {

  String? receiptItemId;
  List<String>? users;
  String? menuName;
  int? menuCount;
  int? menuPrice;
  DocumentReference? reference;

  ReceiptItem ({
    this.receiptItemId,
    this.users,
    this.menuName,
    this.menuCount,
    this.menuPrice,
    this.reference,
  });

  ReceiptItem.fromJson(dynamic json, this.reference) {
    receiptItemId = json['receiptitemid'];
    users = List<String>.from(json["users"]);
    menuName = json['menuname'];
    menuCount = json['menucount'];
    menuPrice = json['menuprice'];
  }

  Map<String, dynamic> toJson() => {
    'receiptitemid' :receiptItemId,
    'users' : users,
    'menuname' : menuName,
    'menucount' : menuCount,
    'menuprice' : menuPrice,
  };

  createReceiptItem(String id, List<String> users,
      String menuname, int menucount, int menuprice) async {

    receiptItemId = id;
    users = users;
    menuName = menuname;
    menuCount = menucount;
    menuPrice = menuprice;

    await FirebaseFirestore.instance.collection("receiptitemlist").doc(id).set(toJson());
    return ReceiptItem;
  }
  
  Future<List<ReceiptItem>> getReceiptItemList() async {
    CollectionReference<Map<String, dynamic>> _collectionReference =
    FirebaseFirestore.instance.collection("receiptitemlist");
    QuerySnapshot<Map<String,dynamic>> querySnapshot =
    await _collectionReference.get();
    List<ReceiptItem> receiptitems = [];
    for(var doc in querySnapshot.docs) {
      ReceiptItem item = ReceiptItem.fromQuerySnapshot(doc);
      receiptitems.add(item);
    }
    return receiptitems;
  }

  Future<ReceiptItem> getReceiptItemByReceiptItemId(String receiptitemid) async {
    DocumentSnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection("receiptitemlist").doc(receiptitemid).get();
    ReceiptItem item = ReceiptItem.fromSnapShot(result);
    return item;
  }

  ReceiptItem.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  ReceiptItem.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :this.fromJson(snapshot.data(), snapshot.reference);
}
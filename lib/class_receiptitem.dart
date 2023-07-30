import 'package:cloud_firestore/cloud_firestore.dart';

class ReceiptItem {

  String? ReceiptItemId;
  List<String>? Users;
  String? MenuName;
  int? MenuCount;
  int? MenuPrice;
  DocumentReference? reference;

  ReceiptItem ({
    this.ReceiptItemId,
    this.Users,
    this.MenuName,
    this.MenuCount,
    this.MenuPrice,
    this.reference,
  });

  ReceiptItem.fromJson(dynamic json, this.reference) {
    ReceiptItemId = json['receiptitemid'];
    Users = List<String>.from(json["users"]);
    MenuName = json['menuname'];
    MenuCount = json['menucount'];
    MenuPrice = json['menuprice'];
  }

  Map<String, dynamic> toJson() => {
    'receiptitemid' :ReceiptItemId,
    'users' : Users,
    'menuname' : MenuName,
    'menucount' : MenuCount,
    'menuprice' : MenuPrice,
  };

  createReceiptItem(String id, List<String> users,
      String menuname, int menucount, int menuprice) async {

    ReceiptItemId = id;
    Users = users;
    MenuName = menuname;
    MenuCount = menucount;
    MenuPrice = menuprice;

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
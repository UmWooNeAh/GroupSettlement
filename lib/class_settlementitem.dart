import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';


class SettlementItem {

  String? ReceiptItemId;
  String? MenuName;
  int? MenuCount;
  Float? Price;
  DocumentReference? reference;

  SettlementItem ({
    this.ReceiptItemId,
    this.MenuName,
    this.MenuCount,
    this.Price,
    this.reference,
  });

  SettlementItem.fromJson(dynamic json, this.reference) {
    ReceiptItemId = json['receiptitemid'];
    MenuCount = json['usercount'];
    MenuName = json['name'];
    Price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic> {};
    map['receiptitemid'] = ReceiptItemId;
    map['usercount'] = MenuCount;
    map['name'] = MenuName;
    map['price'] = Price;

    return map;
  }

  createSettlementItem(String id, int usercount,
    String name, Float price) async {

    ReceiptItemId = id;
    MenuCount = usercount;
    MenuName = name;
    Price = price;

    await FirebaseFirestore.instance.collection("settlemenitemtlist").doc(id).set(toJson());
    return SettlementItem;
  }

  deleteSettlementItem() async {
    await reference!.delete();
  }

  deleteSettlementItemById(String path, String id) async {
    await FirebaseFirestore.instance.collection(path).doc(id).delete();
  }

  updateSettlementItem() async {
    await reference!.update(toJson());
  }

  updateSettlementItemById(String path, String id) async {
    await FirebaseFirestore.instance.collection(path).doc(id).update(toJson());
  }

  Future<List<SettlementItem>> getSettlementItemList() async {
    CollectionReference<Map<String, dynamic>> _collectionReference =
    FirebaseFirestore.instance.collection("settlementitemlist");
    QuerySnapshot<Map<String,dynamic>> querySnapshot =
    await _collectionReference.get();
    List<SettlementItem> items = [];
    for(var doc in querySnapshot.docs) {
      SettlementItem item = SettlementItem.fromQuerySnapshot(doc);
      items.add(item);
    }
    logger.d(items);
    return items;
  }

  Future<SettlementItem> getSettlementItemBySettlementItemId(String settlementitemid) async {
    DocumentSnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection("settlementitemlist").doc(settlementitemid).get();
    SettlementItem item = SettlementItem.fromSnapShot(result);
    return item;
  }

  SettlementItem.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  SettlementItem.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :this.fromJson(snapshot.data(), snapshot.reference);



}
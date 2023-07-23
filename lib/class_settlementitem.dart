import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'fire_service.dart';


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

    await FireService().createSettlementItem(toJson(), id);
    return SettlementItem;
  }

  deleteSettlementItem() async {
    FireService().deleteCollection(reference!);
  }

  deleteSettlementItemById(String path, String id) async {
    FireService().deleteCollectionById(path, id);
  }

  updateSettlementItem() async {
    FireService().updateCollection(reference: reference!, json: toJson());
  }

  updateSettlementItemById(String path, String id) async {
    FireService().updateCollectionById(collectionPath: path ,id: id, json: toJson());
  }

  SettlementItem.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  SettlementItem.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :this.fromJson(snapshot.data(), snapshot.reference);



}
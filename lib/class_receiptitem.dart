import 'package:cloud_firestore/cloud_firestore.dart';
import 'fire_service.dart';


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
    Users = [];
    for(var user in json['users']) {
      Users?.add(user);
    }
    MenuName = json['menuname'];
    MenuCount = json['menucount'];
    MenuPrice = json['menuprice'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic> {};
    map['receiptitemid'] = ReceiptItemId;
    map['users'] = Users;
    map['menuname'] = MenuName;
    map['menucount'] = MenuCount;
    map['menuprice'] = MenuPrice;

    return map;
  }

  createReceiptItem(String id, List<String> users,
      String menuname, int menucount, int menuprice) async {

        ReceiptItemId = id;
        Users = users;
        MenuName = menuname;
        MenuCount = menucount;
        MenuPrice = menuprice;

    await FireService().createReceiptItem(toJson(), id);
    return ReceiptItem;
  }

  deleteRecieptItem() async {
    FireService().deleteCollection(reference!);
  }

  deleteRecieptItemById(String path, String id) async {
    FireService().deleteCollectionById(path, id);
  }

  updateRecieptItem() async {
    FireService().updateCollection(reference: reference!, json: toJson());
  }

  updateRecieptItemById(String path, String id) async {
    FireService().updateCollectionById(collectionPath: path, id: id, json: toJson());
  }

  ReceiptItem.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  ReceiptItem.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :this.fromJson(snapshot.data(), snapshot.reference);
}
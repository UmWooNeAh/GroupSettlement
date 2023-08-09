import 'package:cloud_firestore/cloud_firestore.dart';


class SettlementItem {

  String? settlementItemId;
  String? receiptItemId;
  String? menuName;
  int? menuCount;
  double? price;
  DocumentReference? reference;

  SettlementItem ();

  SettlementItem.fromJson(dynamic json, this.reference) {
    settlementItemId = json['settlementitemid'];
    receiptItemId = json['receiptitemid'];
    menuCount = json['usercount'];
    menuName = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() => {
    'settlementitemid' : settlementItemId,
    'receiptitemid' : receiptItemId,
    'usercount' : menuCount,
    'name' : menuName,
    'price' : price,
  };

  createSettlementItem(String sid, String rid, int usercount,
    String name, Float _price) async {
    settlementItemId = sid;
    receiptItemId = rid;
    menuCount = usercount;
    menuName = name;
    price = _price;

    await FirebaseFirestore.instance.collection("settlemenitemtlist").doc(sid).set(toJson());
    return SettlementItem;
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
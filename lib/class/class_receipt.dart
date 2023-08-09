import 'package:cloud_firestore/cloud_firestore.dart';


class Receipt {

  String? receiptId;
  String? settlementId;
  List<String>? receiptItems = <String> [];
  String? storeName;
  DateTime? time;
  int? totalPrice;
  DocumentReference? reference;

  Receipt ();

  Receipt.fromJson(dynamic json, this.reference) {
    receiptId = json['receiptid'];
    settlementId = json['settlementid'];
    receiptItems = List<String>.from(json["receiptsitems"]);
    storeName = json['storename'];
    time = json['time'];
    totalPrice = json['totalprice'];
  }

  Map<String, dynamic> toJson() => {
    'receiptid' : receiptId,
    'settlementid' : settlementId,
    'receiptitems' : receiptItems,
    'storename' : storeName,
    'time' : time,
    'totalprice' : totalPrice,
  };

  createReceipt(String id, String sid, List<String> receiptitems, String storename,
      DateTime _time, int totalprice) async {

    receiptId = id;
    settlementId = sid;
    receiptItems = receiptitems;
    storeName = storename;
    time = _time;
    totalPrice = totalprice;

    await FirebaseFirestore.instance.collection("receiptlist").doc(id).set(toJson());
    return Receipt;
  }

  Future<List<Receipt>> getReceiptList() async {
    CollectionReference<Map<String, dynamic>> _collectionReference =
    FirebaseFirestore.instance.collection("receiptlist");
    QuerySnapshot<Map<String,dynamic>> querySnapshot =
    await _collectionReference.get();
    List<Receipt> receipts = [];
    for(var doc in querySnapshot.docs) {
      Receipt receipt = Receipt.fromQuerySnapshot(doc);
      receipts.add(receipt);
    }
    return receipts;
  }

  Future<Receipt> getReceiptByReceiptId(String receiptid) async {
    DocumentSnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection("receiptlist").doc(receiptid).get();
    Receipt receipt = Receipt.fromSnapShot(result);
    return receipt;
  }

  Receipt.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  Receipt.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :this.fromJson(snapshot.data(), snapshot.reference);
}
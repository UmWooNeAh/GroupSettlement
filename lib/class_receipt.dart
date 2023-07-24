import 'package:cloud_firestore/cloud_firestore.dart';


class Receipt {

  String? ReceiptId;
  List<String>? ReceiptItems;
  String? StoreName;
  DateTime? Time;
  int? TotalPrice;
  DocumentReference? reference;

  Receipt ({
    this.ReceiptId,
    this.ReceiptItems,
    this.StoreName,
    this.Time,
    this.TotalPrice,
    this.reference,
  });

  Receipt.fromJson(dynamic json, this.reference) {
    ReceiptId = json['receiptid'];
    ReceiptItems = [];
    for(var item in json['receiptitems']) {
      ReceiptItems?.add(item);
    }
    StoreName = json['storename'];
    Time = json['time'];
    TotalPrice = json['totalprice'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic> {};
    map['receiptid'] = ReceiptId;
    map['receiptitems'] = ReceiptItems;
    map['storename'] = StoreName;
    map['time'] = Time;
    map['totalprice'] = TotalPrice;

    return map;
  }

  createReceipt(String id, List<String> receiptitems, String storename,
      DateTime time, int totalprice) async {

    ReceiptId = id;
    ReceiptItems = receiptitems;
    StoreName = storename;
    Time = time;
    TotalPrice = totalprice;

    await FirebaseFirestore.instance.collection("receiptlist").doc(id).set(toJson());
    return Receipt;
  }

  deleteReceipt() async {
    await reference!.delete();
  }

  deleteReceiptById(String path, String id) async {
    await FirebaseFirestore.instance.collection(path).doc(id).delete();
  }

  updateReceipt() async {
    await reference!.update(toJson());
  }

  updateReceiptById(String path, String id) async {
    await FirebaseFirestore.instance.collection(path).doc(id).update(toJson());
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
    logger.d(receipts);
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
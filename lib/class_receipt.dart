import 'package:cloud_firestore/cloud_firestore.dart';
import 'fire_service.dart';


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

  createReceipt(String receiptid, List<String> receiptitems, String storename,
      DateTime time, int totalprice) async {

      ReceiptId = receiptid;
      ReceiptItems = receiptitems;
      StoreName = storename;
      Time = time;
      TotalPrice = totalprice;

    await FireService().createReceipt(toJson(), receiptid);
    return Receipt;
  }

  deleteReceipt() async {
    FireService().deleteCollection(reference!);
  }

  deleteReceiptById(String path, String id) async {
    FireService().deleteCollectionById(path, id);
  }

  updateReceipt() async {
    FireService().updateCollection(reference: reference!, json: toJson());
  }

  updateReceiptById(String path, String id) async {
    FireService().updateCollectionById(collectionPath: path, id: id, json: toJson());
  }

  Receipt.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  Receipt.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :this.fromJson(snapshot.data(), snapshot.reference);
}
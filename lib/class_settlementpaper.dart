import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'fire_service.dart';

class SettlementPaper {

  String? SettlementPaperId;
  String? User;
  List<String>? SettlementItems;
  Float? TotalPrice;
  DocumentReference? reference;

  SettlementPaper ({
    this.SettlementPaperId,
    this.User,
    this.SettlementItems,
    this.TotalPrice,
    this.reference,
  });

  SettlementPaper.fromJson(dynamic json, this.reference) {
    SettlementPaperId = json['settlementpaperid'];
    User = json['user'];
    SettlementItems = [];
    for(var item in json['settlementitems']) {
      SettlementItems?.add(item);
    }
    TotalPrice = json['totalprice'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic> {};
    map['settlementpaperid'] = SettlementPaperId;
    map['user'] = User;
    map['settlementitems'] = SettlementItems;
    map['totalprice'] = TotalPrice;

    return map;
  }

  createSettlementPaper(String id, String user, List<String> items,
      Float totalprice) async {

    SettlementPaperId = id;
    User = user;
    SettlementItems = items;
    TotalPrice = totalprice;

    await FireService().createSettlementPaper(toJson(), id);
    return SettlementPaper;
  }

  updateSettlementPaper() async {
    FireService().updateCollection(reference: reference!, json: toJson());
  }

  updateSettlementPaperById(String path, String id) async {
    FireService().updateCollectionById(collectionPath: path, id: id, json: toJson());
  }

  deleteSettlementPaper() async {
    FireService().deleteCollection(reference!);
  }

  deleteSettlementPaperById(String path, String id) async {
    FireService().deleteCollectionById(path, id);
  }

  SettlementPaper.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  SettlementPaper.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :this.fromJson(snapshot.data(), snapshot.reference);


}
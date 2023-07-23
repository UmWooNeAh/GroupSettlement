import 'package:cloud_firestore/cloud_firestore.dart';
import 'fire_service.dart';

class Settlement {

  String? SettlementId;
  List<String>? Receipts;
  List<String>? SettlementPapers;
  List<String>? Users;
  Map<String, bool>? CheckSent;
  DocumentReference? reference;

  Settlement ({
    this.SettlementId,
    this.Receipts,
    this.SettlementPapers,
    this.Users,
    this.CheckSent,
    this.reference,
  });

  Settlement.fromJson(dynamic json, this.reference) {
    SettlementId = json['settlementid'];
    Receipts = [];
    for(var receipt in json['receipts']) {
      Receipts?.add(receipt);
    }
    SettlementPapers = [];
    for(var paper in json['settlementpapers']) {
      SettlementPapers?.add(paper);
    }
    Users = [];
    for(var user in json['users']) {
      Users?.add(user);
    }
    CheckSent = json['checksent'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic> {};
    map['settlementid'] = SettlementId;
    map['receipts'] = Receipts;
    map['settlementpapers'] = SettlementPapers;
    map['users'] = Users;
    map['checksent'] = CheckSent;

    return map;
  }

  createSettlement(String id, List<String> receipts, List<String> settlementpapers,
      List<String> users, Map<String, bool> checksent) async {

    SettlementId = id;
    Receipts = receipts;
    SettlementPapers = settlementpapers;
    Users = users;
    CheckSent = checksent;

    await FireService().createSettlement(toJson(), id);
    return Settlement;
  }

  deleteSettlement() async {
    FireService().deleteCollection(reference!);
  }

  deleteSettlementById(String path, String id) async {
    FireService().deleteCollectionById(path, id);
  }

  updateSettlement() async {
    FireService().updateCollection(reference: reference!, json: toJson());
  }

  updateSettlementById(String path, String id) async {
    FireService().updateCollectionById(collectionPath: path, id: id, json: toJson());
  }

  Settlement.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  Settlement.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :this.fromJson(snapshot.data(), snapshot.reference);

}
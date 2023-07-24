import 'package:cloud_firestore/cloud_firestore.dart';

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

    await FirebaseFirestore.instance.collection("settlementlist").doc(id).set(toJson());
    return Settlement;
  }

  deleteSettlement() async {
    await reference!.delete();
  }

  deleteSettlementById(String path, String id) async {
    await FirebaseFirestore.instance.collection(path).doc(id).delete();
  }

  updateSettlement() async {
    await reference!.update(toJson());
  }

  updateSettlementById(String path, String id) async {
    await FirebaseFirestore.instance.collection(path).doc(id).update(toJson());
  }

  Future<List<Settlement>> getSettlementList() async {
    CollectionReference<Map<String, dynamic>> _collectionReference =
    FirebaseFirestore.instance.collection("settlementlist");
    QuerySnapshot<Map<String,dynamic>> querySnapshot =
    await _collectionReference.get();
    List<Settlement> settlements = [];
    for(var doc in querySnapshot.docs) {
      Settlement stment = Settlement.fromQuerySnapshot(doc);
      settlements.add(stment);
    }
    logger.d(settlements);
    return settlements;
  }

  Future<Settlement> getSettlementBySettlementId(String settlemntid) async{
    DocumentSnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection("settlemntlist").doc(settlemntid).get();
    Settlement stment = Settlement.fromSnapShot(result);
    return stment;
  }

  Settlement.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  Settlement.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :this.fromJson(snapshot.data(), snapshot.reference);

}
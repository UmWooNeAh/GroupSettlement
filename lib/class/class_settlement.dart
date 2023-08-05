import 'package:cloud_firestore/cloud_firestore.dart';

class Settlement {

  String? settlementId;
  List<String>? receipts;
  List<String>? settlementPapers;
  List<String>? users;
  Map<String, bool>? checkSent;
  DocumentReference? reference;

  Settlement ({
    this.settlementId,
    this.receipts,
    this.settlementPapers,
    this.users,
    this.checkSent,
    this.reference,
  });

  Settlement.fromJson(dynamic json, this.reference) {
    settlementId = json['settlementid'];
    receipts = List<String>.from(json["receipts"]);
    settlementPapers = List<String>.from(json["settlementpapers"]);
    users = List<String>.from(json["users"]);
    checkSent = Map<String, bool>.from(json['checksent']);
  }

  Map<String, dynamic> toJson() => {
    'settlementid' : settlementId,
    'receipts' : receipts,
    'settlementpapers' : settlementPapers,
    'users' : users,
    'checksent' : checkSent,
  };

  createSettlement(String id, List<String> receipts, List<String> settlementpapers,
      List<String> users, Map<String, bool> checksent) async {

    settlementId = id;
    receipts = receipts;
    settlementPapers = settlementpapers;
    users = users;
    checkSent = checksent;

    await FirebaseFirestore.instance.collection("settlementlist").doc(id).set(toJson());
    return Settlement;
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
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettlementPaper {

  String? settlementPaperId;
  String? settlementId;
  String? userId;
  String? accountInfo;
  List<String>? settlementItems;
  Float? totalPrice;
  DocumentReference? reference;

  SettlementPaper ({
    this.settlementPaperId,
    this.settlementId,
    this.userId,
    this.accountInfo,
    this.settlementItems,
    this.totalPrice,
    this.reference,
  });

  SettlementPaper.fromJson(dynamic json, this.reference) {
    settlementPaperId = json['settlementpaperid'];
    settlementId = json['settlementid'];
    userId = json['userid'];
    accountInfo = json['accountinfo'];
    settlementItems = List<String>.from(json["settlementitems"]);
    totalPrice = json['totalprice'];
  }

  Map<String, dynamic> toJson() => {
    'settlementpaperid' : settlementPaperId,
    'settlementid' : settlementId,
    'user' : userId,
    'accountinfo' : accountInfo,
    'settlementitems' : settlementItems,
    'totalprice' : totalPrice,
  };

  createSettlementPaper(String id, String sid, String userid, String accountinfo, List<String> items,
      Float totalprice) async {

    settlementPaperId = id;
    settlementId = sid;
    userId = userid;
    accountInfo = accountinfo;
    settlementItems = items;
    totalPrice = totalprice;

    await FirebaseFirestore.instance.collection("settlementpaperlist").doc(id).set(toJson());
    return SettlementPaper;
  }

  Future<List<SettlementPaper>> getSettlementPaperList() async {
    CollectionReference<Map<String, dynamic>> _collectionReference =
    FirebaseFirestore.instance.collection("settlementpaperlist");
    QuerySnapshot<Map<String,dynamic>> querySnapshot =
    await _collectionReference.get();
    List<SettlementPaper> papers = [];
    for(var doc in querySnapshot.docs) {
      SettlementPaper paper = SettlementPaper.fromQuerySnapshot(doc);
      papers.add(paper);
    }
    return papers;
  }

  Future<SettlementPaper> getSettlementPaperByPaperId(String paperid) async{
    DocumentSnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection("settlemntpaperlist")
        .doc(paperid).get();
    SettlementPaper paper = SettlementPaper.fromSnapShot(result);
    return paper;
  }

  SettlementPaper.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  SettlementPaper.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :this.fromJson(snapshot.data(), snapshot.reference);


}
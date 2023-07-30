import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    SettlementItems = List<String>.from(json["settlementitems"]);
    TotalPrice = json['totalprice'];
  }

  Map<String, dynamic> toJson() => {
    'settlementpaperid' : SettlementPaperId,
    'user' : User,
    'settlementitems' : SettlementItems,
    'totalprice' : TotalPrice,
  };

  createSettlementPaper(String id, String user, List<String> items,
      Float totalprice) async {

    SettlementPaperId = id;
    User = user;
    SettlementItems = items;
    TotalPrice = totalprice;

    await FirebaseFirestore.instance.collection("settlementpaperlist").doc(id).set(toJson());
    return SettlementPaper;
  }

  deleteSettlementPaper() async {
    await reference!.delete();
  }

  deleteSettlementPaperById(String path, String id) async {
    await FirebaseFirestore.instance.collection(path).doc(id).delete();
  }

  updateSettlementPaper() async {
    await reference!.update(toJson());
  }

  updateSettlementPaperById(String path, String id) async {
    await FirebaseFirestore.instance.collection(path).doc(id).update(toJson());
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
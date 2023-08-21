import 'package:cloud_firestore/cloud_firestore.dart';
import 'class_settlement.dart';

class User {
 
  String? serviceUserId;
  String? name;
  String? kakaoId;
  List<String>? groups;
  List<String>? settlements;
  List<String>? settlementPapers;
  DocumentReference? reference;

  User ({
    this.serviceUserId,
    this.name,
    this.kakaoId,
    this.groups,
    this.settlements,
    this.settlementPapers
  });

  User.fromJson(dynamic json, this.reference) {
    serviceUserId = json['serviceuserid'];
    name = json['name'];
    kakaoId = json['kakaoid'];
    groups = List<String>.from(json["groups"]);
    settlements = List<String>.from(json["settlements"]);
    settlementPapers = List<String>.from(json["settlementpapers"]);
  }

  Map<String, dynamic> toJson() => {
    'serviceuserid' : serviceUserId,
    'name' : name,
    'kakaoid' : kakaoId,
    'groups' : groups,
    'settlements' : settlements,
    'settlementpapers' : settlementPapers,
  };

  void createUser() async {
    await FirebaseFirestore.instance.collection("userlist").doc(serviceUserId).set(toJson());
  }

  Future<List<User>> getUserList() async {
    CollectionReference<Map<String, dynamic>> _collectionReference =
    FirebaseFirestore.instance.collection("userlist");
    QuerySnapshot<Map<String,dynamic>> querySnapshot =
    await _collectionReference.get();
    List<User> users = [];
    for(var doc in querySnapshot.docs) {
      User user = User.fromQuerySnapshot(doc);
      users.add(user);
    }
    return users;
  }

  Future<User> getUserByUserId(String userid) async{
    DocumentSnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection("userlist").doc(userid).get();
    User user = User.fromSnapShot(result);
    return user;
  }

  Future<List<Settlement>> getSettlementListInUser() async {
    List<Settlement> stmlist = [];
    for(var stmid in settlements!) {
      DocumentSnapshot<Map<String, dynamic>> result =
      await FirebaseFirestore.instance.collection("settlementlist").doc(stmid).get();
      Settlement stm = Settlement.fromSnapShot(result);
      stmlist.add(stm);
    }
    return stmlist;
  }

  User.fromSnapShot(
    DocumentSnapshot<Map<String, dynamic>> snapshot)
    : this.fromJson(snapshot.data(), snapshot.reference);

  User.fromQuerySnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
    :this.fromJson(snapshot.data(), snapshot.reference);

}


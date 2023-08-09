import 'package:cloud_firestore/cloud_firestore.dart';
import 'class_settlement.dart';

class User {
 
  String? userId;
  String? name;
  String? kakaoId;
  List<String> groups = <String> [];
  List<String> settlements = <String> [];
  List<String> settlementPapers = <String> [];
  DocumentReference? reference;

  User ();

  User.fromJson(dynamic json, this.reference) {
    userId = json['userid'];
    name = json['name'];
    kakaoId = json['kakaoid'];
    groups = List<String>.from(json["groups"]);
    settlements = List<String>.from(json["settlements"]);
    settlementPapers = List<String>.from(json["settlementpapers"]);
  }

  Map<String, dynamic> toJson() => {
    'userid' : userId,
    'name' : name,
    'kakaoid' : kakaoId,
    'groups' : groups,
    'settlements' : settlements,
    'settlementpapers' : settlementPapers,
  };

  createUser(String userid, String _name, String kakaoid,
      List<String> _groups, List<String> _settlements, List<String> settlementpapers) async {
    userId = userid;
    name = _name;
    kakaoId = kakaoid;
    groups = _groups;
    settlements = _settlements;
    settlementPapers = settlementpapers;
    await FirebaseFirestore.instance.collection("userlist").doc(userid).set(toJson());
    return User;
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


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/common_fireservice.dart';
class User {
 
  String? userId;
  String? name;
  String? kakaoId;
  List<String>? groups;
  List<String>? settlements;
  List<String>? settlementPapers;

  DocumentReference? reference;

  User ({
    this.userId,
    this.name,
    this.kakaoId,
    this.reference,
});

  User.fromJson(dynamic json, this.reference) {
    userId = json['userid'];
    name = json['name'];
    kakaoId = json['kakaoid'];
  }

  Map<String, dynamic> toJson() => {
    'userid' : userId,
    'name' : name,
    'kakaoid' : kakaoId,
  };

  createUser(String userid, String _name, String kakaoid) async {
    userId = userid;
    name = _name;
    kakaoId = kakaoid;
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

  User.fromSnapShot(
    DocumentSnapshot<Map<String, dynamic>> snapshot)
    : this.fromJson(snapshot.data(), snapshot.reference);

  User.fromQuerySnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
    :this.fromJson(snapshot.data(), snapshot.reference);

}


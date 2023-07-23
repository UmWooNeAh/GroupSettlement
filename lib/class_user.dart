import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  String? UserId;
  String? Name;
  String? KakaoId;
  DocumentReference? reference;

  User ({
    this.UserId,
    this.Name,
    this.KakaoId,
    this.reference,
});

  User.fromJson(dynamic json, this.reference) {
    UserId = json['userid'];
    Name = json['name'];
    KakaoId = json['kakaoid'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic> {};
    map['userid'] = UserId;
    map['name'] = Name;
    map['kakaoid'] = KakaoId;
    return map;
  }

  createUser(String userid, String name, String kakaoid) async {
    UserId = userid;
    Name = name;
    KakaoId = kakaoid;
    await FirebaseFirestore.instance.collection("userlist").doc(userid).set(toJson());
    return User;
  }

  deleteUser() async{
    await reference!.delete();
  }

  deleteUserByid(String path, String id) async {
    await FirebaseFirestore.instance.collection(path).doc(id).delete();
  }

  UpdateUser() async {
    await reference!.update(toJson());
  }

  UpdateUserByid(String path, String id) async {
    await FirebaseFirestore.instance.collection(path).doc(id).update(toJson());
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

  User.fromSnapShot(
    DocumentSnapshot<Map<String, dynamic>> snapshot)
    : this.fromJson(snapshot.data(), snapshot.reference);

  User.fromQuerySnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
    :this.fromJson(snapshot.data(), snapshot.reference);

}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'class_settlement.dart';
import 'class_user.dart';

class Group {

  String? groupId;
  List<String>? settlements = <String> [];
  List<String>? users = <String> [];
  String? groupName;
  DocumentReference? reference;

  Group ();

  Group.fromJson(dynamic json, this.reference) {

    groupId = json['groupid'];
    settlements = List<String>.from(json["settlements"]);
    users = List<String>.from(json["users"]);
    groupName = json['groupName'];
  }

  Map<String, dynamic> toJson() => {
    'groupid' : groupId,
    'settlements': settlements,
    'users' : users,
    'groupName' : groupName,
  };

  createGroup(String groupid, List<String> _settlements,
      List<String> _users, String groupname) async {

    groupId = groupid;
    settlements = _settlements;
    users = _users;
    groupName = groupname;

    await FirebaseFirestore.instance.collection("grouplist").doc(groupid).set(toJson());
    return Group;
  }

  Future<List<Group>> getGroupList() async {
    CollectionReference<Map<String, dynamic>> _collectionReference =
    FirebaseFirestore.instance.collection("grouplist");
    QuerySnapshot<Map<String,dynamic>> querySnapshot =
    await _collectionReference.get();
    List<Group> groups = [];
    for(var doc in querySnapshot.docs) {
      Group group = Group.fromQuerySnapshot(doc);
      groups.add(group);
    }
    return groups;
  }

  Future<Group> getGroupByGroupId(String groupid) async{
    DocumentSnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection("grouplist").doc(groupid).get();
    Group group = Group.fromSnapShot(result);
    return group;
  }

  Future<List<User>> getUserListInGroup() async {
    List<User> userlist = [];
    for(var userid in users!) {
      DocumentSnapshot<Map<String, dynamic>> result =
      await FirebaseFirestore.instance.collection("userlist").doc(userid).get();
      User user = User.fromSnapShot(result);
      userlist.add(user);
    }
    return userlist;
  }

  Future<List<Settlement>> getSettlementListInGroup() async {
    List<Settlement> stmlist = [];
    for(var stmid in settlements!) {
      DocumentSnapshot<Map<String, dynamic>> result =
      await FirebaseFirestore.instance.collection("settlementlist").doc(stmid).get();
      Settlement stm = Settlement.fromSnapShot(result);
      stmlist.add(stm);
    }
    return stmlist;
  }

  Group.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  Group.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :this.fromJson(snapshot.data(), snapshot.reference);

}
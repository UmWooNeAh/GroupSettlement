import 'package:cloud_firestore/cloud_firestore.dart';

class Group {

  String? GroupId;
  List<String>? Settlements;
  List<String>? Users;
  String? GroupName;
  DocumentReference? reference;

  Group ({
    this.GroupId,
    this.Settlements,
    this.Users,
    this.GroupName,
    this.reference,
  });

  Group.fromJson(dynamic json, this.reference) {

    GroupId = json['groupid'];
    Settlements = List<String>.from(json["settlements"]);
    Users = List<String>.from(json["users"]);
    GroupName = json['groupName'];
  }

  Map<String, dynamic> toJson() => {
    'groupid' : GroupId,
    'settlements': Settlements,
    'users' : Users,
    'groupName' : GroupName,
  };

  createGroup(String groupid, List<String> settlements,
      List<String> users, String groupname) async {

    GroupId = groupid;
    Settlements = settlements;
    Users = users;
    GroupName = groupname;

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

  Group.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  Group.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :this.fromJson(snapshot.data(), snapshot.reference);

}
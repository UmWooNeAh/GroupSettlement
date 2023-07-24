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
    Settlements = [];
    for(var settlement in json['settlements']) {
      Settlements?.add(settlement);
    }
    Users = [];
    for(var user in json['users']) {
      Users?.add(user);
    }
    GroupName = json['groupName'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic> {};

    map['groupid'] = GroupId;
    map['settlements'] = Settlements;
    map['users'] = Users;
    map['groupName'] = GroupName;
    return map;
  }

  createGroup(String groupid, List<String> settlements,
      List<String> users, String groupname) async {

    GroupId = groupid;
    Settlements = settlements;
    Users = users;
    GroupName = groupname;

    await FirebaseFirestore.instance.collection("grouplist").doc(groupid).set(toJson());
    return Group;
  }

  deleteGroup() async {
    await reference!.delete();
  }

  deleteGroupByid(String path, String id) async {
    await FirebaseFirestore.instance.collection(path).doc(id).delete();
  }

  updateGroup() async{
    await reference!.update(toJson());
  }

  updateGroupByid(String path, String id) async {
    await FirebaseFirestore.instance.collection(path).doc(id).update(toJson());
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
    logger.d(groups);
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'fire_service.dart';

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

    await FireService().createGroup(toJson(), groupid);
    return Group;
  }

  deleteGroup() async {
    FireService().deleteCollection(reference!);
  }

  deleteGroupByid(String path, String id) async {
    FireService().deleteCollectionById(path, id);
  }

  updateGroup() async{
    FireService().updateCollection(reference: reference!, json: toJson());
  }

  updateGroupByid(String path, String id) async {
    FireService().deleteCollectionById(path, id);
  }

  Group.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  Group.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :this.fromJson(snapshot.data(), snapshot.reference);

}
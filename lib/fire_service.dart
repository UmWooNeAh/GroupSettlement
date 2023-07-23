import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/class_receiptitem.dart';
import 'package:untitled/class_settlementitem.dart';
import 'package:untitled/class_settlementpaper.dart';
import 'package:untitled/class_user.dart';
import 'package:untitled/class_group.dart';
import 'package:logger/logger.dart';
import 'class_receipt.dart';
import 'class_settlement.dart';
var logger = Logger();

class FireService {

  static final FireService _fireService = FireService.internal();
  factory FireService() => _fireService;
  FireService.internal();

  Future createUser(Map<String, dynamic> json, String key) async {
    await FirebaseFirestore.instance.collection("userlist").doc(key).set(json);
  }
  Future createGroup(Map<String, dynamic> json, String key) async {
    await FirebaseFirestore.instance.collection("grouplist").doc(key).set(json);
  }
  Future createSettlement(Map<String, dynamic> json, String key) async {
    await FirebaseFirestore.instance.collection("settlementlist").doc(key).set(json);
  }
  Future createSettlementPaper(Map<String, dynamic> json, String key) async {
    await FirebaseFirestore.instance.collection("settlementpaperlist").doc(key).set(json);
  }
  Future createSettlementItem(Map<String, dynamic> json, String key) async {
    await FirebaseFirestore.instance.collection("settlemenitemtlist").doc(key).set(json);
  }
  Future createReceipt(Map<String, dynamic> json, String key) async {
    await FirebaseFirestore.instance.collection("receiptlist").doc(key).set(json);
  }
  Future createReceiptItem(Map<String, dynamic> json, String key) async {
    await FirebaseFirestore.instance.collection("receiptitemlist").doc(key).set(json);
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
      logger.d(users);
      return users;
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

  Future<List<Settlement>> getSettlementList() async {
    CollectionReference<Map<String, dynamic>> _collectionReference =
    FirebaseFirestore.instance.collection("settlementlist");
    QuerySnapshot<Map<String,dynamic>> querySnapshot =
    await _collectionReference.get();
    List<Settlement> settlements = [];
    for(var doc in querySnapshot.docs) {
      Settlement stment = Settlement.fromQuerySnapshot(doc);
      settlements.add(stment);
    }
    logger.d(settlements);
    return settlements;
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
    logger.d(papers);
    return papers;
  }

  Future<List<SettlementItem>> getSettlementItemList() async {
    CollectionReference<Map<String, dynamic>> _collectionReference =
    FirebaseFirestore.instance.collection("settlementitemlist");
    QuerySnapshot<Map<String,dynamic>> querySnapshot =
    await _collectionReference.get();
    List<SettlementItem> items = [];
    for(var doc in querySnapshot.docs) {
      SettlementItem item = SettlementItem.fromQuerySnapshot(doc);
      items.add(item);
    }
    logger.d(items);
    return items;
  }

  Future<List<Receipt>> getReceiptList() async {
    CollectionReference<Map<String, dynamic>> _collectionReference =
    FirebaseFirestore.instance.collection("receiptlist");
    QuerySnapshot<Map<String,dynamic>> querySnapshot =
    await _collectionReference.get();
    List<Receipt> receipts = [];
    for(var doc in querySnapshot.docs) {
      Receipt receipt = Receipt.fromQuerySnapshot(doc);
      receipts.add(receipt);
    }
    logger.d(receipts);
    return receipts;
  }

  Future<List<ReceiptItem>> getReceiptItemList() async {
    CollectionReference<Map<String, dynamic>> _collectionReference =
    FirebaseFirestore.instance.collection("receiptitemlist");
    QuerySnapshot<Map<String,dynamic>> querySnapshot =
    await _collectionReference.get();
    List<ReceiptItem> receiptitems = [];
    for(var doc in querySnapshot.docs) {
      ReceiptItem item = ReceiptItem.fromQuerySnapshot(doc);
      receiptitems.add(item);
    }
    logger.d(receiptitems);
    return receiptitems;
  }



  Future<User> getUserByUserId(String userid) async{
    DocumentSnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection("userlist").doc(userid).get();
    User user = User.fromSnapShot(result);
    return user;
  }

  Future<Group> getGroupByGroupId(String groupid) async{
    DocumentSnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection("grouplist").doc(groupid).get();
    Group group = Group.fromSnapShot(result);
    return group;
  }

  Future<Settlement> getSettlementBySettlementId(String settlemntid) async{
    DocumentSnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection("settlemntlist").doc(settlemntid).get();
    Settlement stment = Settlement.fromSnapShot(result);
    return stment;
  }

  Future<SettlementPaper> getSettlementPaperByPaperId(String paperid) async{
    DocumentSnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection("settlemntpaperlist")
        .doc(paperid).get();
    SettlementPaper paper = SettlementPaper.fromSnapShot(result);
    return paper;
  }

  Future<SettlementItem> getSettlementItemBySettlementItemId(String settlementitemid) async {
    DocumentSnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection("settlementitemlist").doc(settlementitemid).get();
    SettlementItem item = SettlementItem.fromSnapShot(result);
    return item;
  }

  Future<Receipt> getReceiptByReceiptId(String receiptid) async {
    DocumentSnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection("receiptlist").doc(receiptid).get();
    Receipt receipt = Receipt.fromSnapShot(result);
    return receipt;
  }

  Future<ReceiptItem> getReceiptItemByReceiptItemId(String receiptitemid) async {
    DocumentSnapshot<Map<String, dynamic>> result =
    await FirebaseFirestore.instance.collection("receiptitemlist").doc(receiptitemid).get();
    ReceiptItem item = ReceiptItem.fromSnapShot(result);
    return item;
  }

  Future updateCollection(
      {required DocumentReference reference, required Map<String, dynamic> json}) async {
    await reference.update(json);
  }

  Future updateCollectionById(
      {required String collectionPath, required String id, required Map<String, dynamic> json}) async {
    await FirebaseFirestore.instance.collection(collectionPath).doc(id).update(json);
  }

  Future<void> deleteCollection(DocumentReference reference) async {
    await reference.delete();
  }

  Future<void> deleteCollectionById(String collectionPath, String id) async {
    await FirebaseFirestore.instance.collection(collectionPath).doc(id).delete();
  }
  
}
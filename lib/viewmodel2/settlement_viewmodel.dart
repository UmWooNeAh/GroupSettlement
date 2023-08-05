import 'dart:ffi';

import '../class/class_receipt.dart';
import '../class/class_receiptitem.dart';
import '../class/class_settlement.dart';
import '../class/class_settlementitem.dart';
import '../class/class_settlementpaper.dart';

class SettlementViewModel{
  // Information
  Settlement                   settlement       = Settlement();
  Map<String, Receipt>         receipts         = <String, Receipt>{};
  Map<String, ReceiptItem>     receiptItems     = <String, ReceiptItem>{};

  // Management
  List<String>                 finalSettlement  = <String>[];
  Map<String, SettlementPaper> settlementPapers = <String, SettlementPaper>{};
  Map<String, SettlementItem>  settlementItems  = <String, SettlementItem>{};

  SettlementViewModel(String settlementId){
    _settingSettlementViewModel(settlementId);
  }

  void _settingSettlementViewModel(String settlementId) async{
    settlement.getSettlementBySettlementId(settlementId);
    for(int i = 0; i < settlement.receipts!.length; i++){
      // Settlement -> Receipt 하나씩 불러오기
      Receipt newReceipt = Receipt();
      receipts[settlement.receipts![i]] = await newReceipt.getReceiptByReceiptId(settlement.receipts![i]);
      for(int j = 0; j < receipts[settlement.receipts![i]]!.receiptItems!.length; j++){
        // Receipt -> ReceiptItem 하나씩 불러오기
        ReceiptItem newReceiptItem = ReceiptItem();
        receiptItems[receipts[settlement.receipts![i]]!.receiptItems![j]] =
            await newReceiptItem.getReceiptItemByReceiptItemId(receipts[settlement.receipts![i]]!.receiptItems![j]);
      }
    }
  }

  void addSettlementItem(String receiptItemId, String userId){
    // receiptItem이 선택이 됐었는지에 따라 userId를 추가해주기 + 처음 선택됐을 때 finalSettlement에 추가
    if(receiptItems[receiptItemId]!.users == null){
      receiptItems[receiptItemId]!.users = [userId];
      finalSettlement.add(receiptItemId);
    }
    else{
      receiptItems[receiptItemId]!.users!.add(userId);
    }

    // userId에 따른 SettlementPaper가 없었을 때 생성후 settlement에 등록
    if(!settlementPapers.containsKey(userId)){
      SettlementPaper newSettlementPaper = SettlementPaper(userId: userId);
      newSettlementPaper.settlementPaperId = "aflkwcufhknwefgawkebygavwieufvhanlwieuvfhalwieuh";
      settlementPapers[userId] = newSettlementPaper;

      if(settlement.settlementPapers == null){
        settlement.settlementPapers = [newSettlementPaper.settlementPaperId ?? "default_settlement_paper_id"];
      }
      else{
        settlement.settlementPapers!.add(newSettlementPaper.settlementPaperId ?? "default_settlement_paper_id");
      }
    }

    SettlementItem newSettlementItem = SettlementItem();
    newSettlementItem.receiptItemId    = "abwlejkfbalwjkebfajbefaw";
    newSettlementItem.settlementItemId = "afewawbfkawhebflajwebhlawhb";
    newSettlementItem.menuName         = receiptItems[receiptItemId]!.menuName;
    newSettlementItem.menuCount        = receiptItems[receiptItemId]!.users!.length;
    newSettlementItem.price            = (receiptItems[receiptItemId]!.menuPrice!.toDouble() / newSettlementItem.menuCount!.toDouble()) as Float?;

    if(settlementPapers[userId]!.settlementItems == null){
      settlementPapers[userId]!.settlementItems = [newSettlementItem.settlementItemId];
    }
    else{
      settlementPapers[userId]!.settlementItems!.add(newSettlementItem.settlmentItemId);
    }
    _updateSettlementItemPrice(receiptItemId);

  }

  void _updateSettlementItemPrice(String receiptItemId){
    for(int i = 0; i < receiptItems[receiptItemId]!.users!.length; i++){
      for(int j = 0; j < settlementPapers[receiptItems[receiptItemId]!.users![i]]!.settlementItems!.length; j++){
        if(settlementItems[settlementPapers[receiptItems[receiptItemId]!.users![i]]!.settlementItems![j]]!.receiptItemId == receiptItemId){
          settlementItems[settlementPapers[receiptItems[receiptItemId]!.users![i]]!.settlementItems![j]]!.menuCount =
              receiptItems[receiptItemId]!.users!.length;
          settlementItems[settlementPapers[receiptItems[receiptItemId]!.users![i]]!.settlementItems![j]]!.price =
              (receiptItems[receiptItemId]!.menuPrice!.toDouble() / receiptItems[receiptItemId]!.users!.length.toDouble()) as Float?;
          break;
        }
      }
    }
  }


}
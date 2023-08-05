import '../class/class_receipt.dart';
import '../class/class_settlement.dart';
import '../class/class_settlementpaper.dart';

class SettlementViewModel{
  Settlement? settlement;
  List<Receipt> receipts;
  List<SettlementPaper> settlementPapers;


  //정산 하는데 있어서 필요한 것들은

  SettlementViewModel(String settlementId){
    settlement = Settlement(SettlementId:settlementId);

    //settlement 내부에 모든 값 가져오기

    //
  }

  int addSettlementItem(receiptItemId, userId){
    for(int i = 0; i < settlementPapers.length; i++){
      if(settlementPapers[i].)
    }
    return 0;
  }
}
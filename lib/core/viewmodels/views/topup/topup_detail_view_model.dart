import 'package:member_apps/core/models/topup_model.dart';
import 'package:member_apps/core/services/topup_service.dart';
import 'package:member_apps/core/services/wallet_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class TopupDetailViewModel extends BaseViewModel {
  TopupService _topupService;
  WalletService _walletService;
//  int _topupAmount=0;
  bool topupButtonIsDisabled = true;
  TopupModel topupModel;

  TopupDetailViewModel({TopupService topupService, WalletService walletService}) {
    this._topupService = topupService;
    this._walletService = walletService;
  }

  Future getTopUpDetail({String id}) async {
    setBusy(true);
    topupModel = await _topupService.loadTopUp(id: id);
    setBusy(false);
  }

  Future loadTopup() async {
      await _topupService.loadHistories();
      await _walletService.loadWallet();
      setBusy(false);

  }
}

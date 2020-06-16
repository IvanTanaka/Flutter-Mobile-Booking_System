import 'package:member_apps/core/services/wallet_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class WalletContainerViewModel extends BaseViewModel {
  WalletService _walletService;
  String get walletAmount => _walletService.walletAmountFormatted;

  WalletContainerViewModel({WalletService walletService}) {
    this._walletService = walletService;
  }

  Future loadWallet() async {
    setBusy(true);
    await _walletService.loadWallet();
    setBusy(false);
  }
}

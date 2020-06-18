import 'package:member_apps/core/models/topup_model.dart';
import 'package:member_apps/core/services/topup_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class TopupViewModel extends BaseViewModel {
  TopupService _topupService;
  int _topupAmount=0;
  bool topupButtonIsDisabled = true;
  TopupModel _topupModel;
  String get topUpId => _topupModel.id;

  TopupViewModel({TopupService topupService}) {
    this._topupService = topupService;
  }

  void validateTopUp(String value){
    _topupAmount = int.parse(value.substring(value.indexOf(" ")).replaceAll(".", ""));
    topupButtonIsDisabled = _topupAmount<10000;
    setBusy(false);
  }

  Future topUp() async {
    setBusy(true);
    _topupModel = await _topupService.topUp(amount: _topupAmount);
    setBusy(false);
  }
}

import 'package:member_apps/core/models/topup_model.dart';
import 'package:member_apps/core/services/topup_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class TopupDetailViewModel extends BaseViewModel {
  TopupService _topupService;
//  int _topupAmount=0;
  bool topupButtonIsDisabled = true;
  TopupModel topupModel;

  TopupDetailViewModel({TopupService topupService}) {
    this._topupService = topupService;
  }

  Future getTopUpDetail({String id}) async {
    setBusy(true);
    topupModel = await _topupService.loadTopUp(id: id);
    setBusy(false);
  }

  Future loadTopup() async {
      setBusy(true);
      await _topupService.loadHistories();
      setBusy(false);

  }
}

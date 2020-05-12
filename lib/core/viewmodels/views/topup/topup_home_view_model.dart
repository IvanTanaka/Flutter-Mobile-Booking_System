import 'package:member_apps/core/models/topup_model.dart';
import 'package:member_apps/core/services/topup_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class TopupHomeViewModel extends BaseViewModel {
  TopupService _topupService;
  List<TopupModel> get topups => _topupService.topups;

  TopupHomeViewModel({TopupService topupService}) {
    this._topupService = topupService;
  }

  Future loadHistories() async {
    setBusy(true);
    await _topupService.loadHistories();
    setBusy(false);
  }
}

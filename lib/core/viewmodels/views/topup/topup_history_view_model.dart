import 'package:member_apps/core/models/topup_model.dart';
import 'package:member_apps/core/services/topup_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class TopupHistoryViewModel extends BaseViewModel {
  TopupService _topupService;
  List<TopupModel> topups = [];
  int _page = 0;

  TopupHistoryViewModel({TopupService topupService}) {
    this._topupService = topupService;

    _page = 0;
  }

  Future loadHistories() async {
    setBusy(true);
    _page++;
    List<TopupModel> _tempModel = await _topupService.loadHistories(page: _page);
    topups.addAll(_tempModel);
    setBusy(false);
  }
}

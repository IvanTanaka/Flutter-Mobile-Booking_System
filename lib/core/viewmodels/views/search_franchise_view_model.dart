import 'package:member_apps/core/enumerations/booking_service_type.dart';
import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/search_store_model.dart';
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/services/store_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';
import 'package:member_apps/ui/prototype_constant.dart';

class SearchFranchiseViewModel extends BaseViewModel {
  BookingServiceType type;
  StoreService _storeService;
  bool listIsUpdate = false;
  int page=1;

  SearchFranchiseViewModel({StoreService storeService}){
    this._storeService = storeService;
  }


  List<SearchStoreModel> searchStoreModel = [];

  // ignore: missing_return
  String get searchPageTitle {
    switch (this.type) {
      case BookingServiceType.food:
        return "Search Restaurant";
        break;
      case BookingServiceType.barber:
        return "Search Barbershop";
        break;
      case BookingServiceType.karaoke:
        return "Search Karaoke";
        break;
      case BookingServiceType.sport:
        return "Search Sport Field";
        break;
    }
  }

  // ignore: missing_return
  String get searchPagePlaceholder {
    switch (this.type) {
      case BookingServiceType.food:
        return "Search restaurant name";
        break;
      case BookingServiceType.barber:
        return "Search barbershop";
        break;
      case BookingServiceType.karaoke:
        return "Search karaoke place";
        break;
      case BookingServiceType.sport:
        return "Search court";
        break;
    }
  }

  Future getStoreByName(String name) async {
    setBusy(true);
    page=1;
    searchStoreModel = await _storeService.getStoresByFilter(type: type, name: name);
    setBusy(false);
  }

  Future getMoreStoreByName(String name) async {
    if(!listIsUpdate){
      listIsUpdate = true;
      notifyListeners();
      page++;
      List<SearchStoreModel> tempList = await _storeService.getStoresByFilter(type: type, name: name,page: page);
      listIsUpdate = false;
      searchStoreModel.addAll(tempList);
      setBusy(false);}
  }
}

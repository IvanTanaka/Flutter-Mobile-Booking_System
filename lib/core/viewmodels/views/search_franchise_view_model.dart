import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/search_store_model.dart';
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/services/store_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';
import 'package:member_apps/ui/prototype_constant.dart';

class SearchFranchiseViewModel extends BaseViewModel {
  ServiceType type;
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
      case ServiceType.food:
        return "Search Restaurant";
        break;
      case ServiceType.barber:
        return "Search Barbershop";
        break;
      case ServiceType.karaoke:
        return "Search Karaoke";
        break;
      case ServiceType.sport:
        return "Search Sport Field";
        break;
    }
  }

  // ignore: missing_return
  String get searchPagePlaceholder {
    switch (this.type) {
      case ServiceType.food:
        return "Search restaurant name";
        break;
      case ServiceType.barber:
        return "Search barbershop";
        break;
      case ServiceType.karaoke:
        return "Search karaoke place";
        break;
      case ServiceType.sport:
        return "Search court";
        break;
    }
  }

  Future getStoreByName(String name) async {
    setBusy(true);
    page=1;
    searchStoreModel = await _storeService.getStoreByFilter(type: type, name: name);
    setBusy(false);
  }

  Future getMoreStoreByName(String name) async {
    if(!listIsUpdate){
      listIsUpdate = true;
      notifyListeners();
      page++;
      List<SearchStoreModel> tempList = await _storeService.getStoreByFilter(type: type, name: name,page: page);
      listIsUpdate = false;
      searchStoreModel.addAll(tempList);
      setBusy(false);}
  }
}

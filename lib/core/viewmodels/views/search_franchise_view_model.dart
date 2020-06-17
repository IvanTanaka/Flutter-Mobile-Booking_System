import 'package:member_apps/core/models/search_store_model.dart';
import 'package:member_apps/core/services/store_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class SearchFranchiseViewModel extends BaseViewModel {
  String food_category;
  StoreService _storeService;
  bool listIsUpdate = false;
  int page=1;

  SearchFranchiseViewModel({StoreService storeService}){
    this._storeService = storeService;
  }


  List<SearchStoreModel> searchStoreModel = [];

  Future getStoreByName(String name) async {
    setBusy(true);
    page=1;
    searchStoreModel = await _storeService.getStoresByFilter(foodCategory: food_category, name: name);
    setBusy(false);
  }

  Future getMoreStoreByName(String name) async {
    if(!listIsUpdate){
      listIsUpdate = true;
      notifyListeners();
      page++;
      List<SearchStoreModel> tempList = await _storeService.getStoresByFilter(foodCategory: food_category, name: name,page: page);
      listIsUpdate = false;
      searchStoreModel.addAll(tempList);
      setBusy(false);}
  }
}

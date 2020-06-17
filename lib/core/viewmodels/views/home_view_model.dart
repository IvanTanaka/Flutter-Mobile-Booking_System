import 'package:member_apps/core/constants/food_category.dart';
import 'package:member_apps/core/models/news_model.dart';
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/services/news_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  NewsService _newsService;
  List<NewsModel> get news => _newsService.news;

  HomeViewModel({NewsService newsService}){
    this._newsService = newsService;
  }

  Future loadNews() async {
    setBusy(true);
    await _newsService.loadNews();
    setBusy(false);
  }

  List<ServiceMenuModel> serviceMenus = [
    ServiceMenuModel(FoodCategory.FAST_FOOD),
    ServiceMenuModel(FoodCategory.SEA_FOOD),
    ServiceMenuModel(FoodCategory.SALAD),
    ServiceMenuModel(FoodCategory.DRINKS),
  ];
}
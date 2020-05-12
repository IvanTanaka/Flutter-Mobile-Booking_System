import 'package:member_apps/core/models/news_model.dart';
import 'package:member_apps/core/models/search_store_model.dart';
import 'package:member_apps/core/services/news_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class NewsViewModel extends BaseViewModel {
  NewsService _newsService;
  List<NewsModel> get news => _newsService.news;

  NewsViewModel({NewsService newsService}){
    this._newsService= newsService;
  }


  List<SearchStoreModel> searchStoreModel = [];

  Future loadNews() async {
    setBusy(true);
    await _newsService.loadNews();
    setBusy(false);
  }

}

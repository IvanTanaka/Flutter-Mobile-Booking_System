import 'package:member_apps/core/models/news_detail_model.dart';
import 'package:member_apps/core/models/search_store_model.dart';
import 'package:member_apps/core/services/news_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class NewsDetailViewModel extends BaseViewModel {
  NewsService _newsService;
  NewsDetailModel newsDetail;
  int page=0;

  NewsDetailViewModel({NewsService newsService}){
    this._newsService= newsService;
  }


  List<SearchStoreModel> searchStoreModel = [];

  Future loadNewsDetail({String newsId}) async {
    setBusy(true);
    newsDetail = await _newsService.loadNewsDetail(newsId: newsId);
    setBusy(false);
  }

}

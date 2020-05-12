
import 'package:member_apps/core/enumerations/booking_service_type.dart';
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
    ServiceMenuModel(BookingServiceType.food),
    ServiceMenuModel(BookingServiceType.barber),
    ServiceMenuModel(BookingServiceType.karaoke),
    ServiceMenuModel(BookingServiceType.sport),
  ];
}
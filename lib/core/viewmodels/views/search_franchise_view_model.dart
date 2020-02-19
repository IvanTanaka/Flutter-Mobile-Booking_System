import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/viewmodels/base_viewmodel.dart';

class SearchFranchiseViewModel extends BaseViewmodel {

  ServiceMenuType type;

  // ignore: missing_return
  String get searchPageTitle{
    switch(this.type){
      case ServiceMenuType.food:
        return "Search Restaurant";
        break;
      case ServiceMenuType.barber:
        return "Search Barbershop";
        break;
      case ServiceMenuType.karaoke:
        return "Search Karaoke";
        break;
      case ServiceMenuType.sport:
        return "Search Sport Field";
        break;
    }
  }

  // ignore: missing_return
  String get searchPagePlaceholder{
    switch(this.type){
      case ServiceMenuType.food:
        return "Search restaurant name";
        break;
      case ServiceMenuType.barber:
        return "Search barbershop";
        break;
      case ServiceMenuType.karaoke:
        return "Search karaoke place";
        break;
      case ServiceMenuType.sport:
        return "Search court";
        break;
    }
  }
}
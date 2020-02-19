
import 'package:get_it/get_it.dart';
import 'package:member_apps/core/services/api.dart';
import 'package:member_apps/core/services/connection_service.dart';
import 'package:member_apps/core/viewmodels/views/home_view_model.dart';
import 'package:member_apps/core/viewmodels/views/search_franchise_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<Api>(Api());
  locator.registerSingleton<ConnectionService>(ConnectionService());

  locator.registerFactory<HomeViewModel>(()=>HomeViewModel());
  locator.registerFactory<SearchFranchiseViewModel>(()=>SearchFranchiseViewModel());
}
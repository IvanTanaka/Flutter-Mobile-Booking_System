import 'package:get_it/get_it.dart';
import 'package:member_apps/core/services/api.dart';
import 'package:member_apps/core/services/connection_service.dart';
import 'package:member_apps/core/services/order_service.dart';
import 'package:member_apps/core/services/product_service.dart';
import 'package:member_apps/core/services/store_service.dart';
import 'package:member_apps/core/viewmodels/views/home_view_model.dart';
import 'package:member_apps/core/viewmodels/views/order/order_food_confirmation_view_model.dart';
import 'package:member_apps/core/viewmodels/views/order/order_food_store_view_model.dart';
import 'package:member_apps/core/viewmodels/views/search_franchise_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<Api>(Api());
  locator.registerSingleton<ConnectionService>(ConnectionService());

  locator.registerLazySingleton<StoreService>(
    () => StoreService(
      api: locator<Api>(),
    ),
  );

  locator.registerLazySingleton<ProductService>(
    () => ProductService(
      api: locator<Api>(),
    ),
  );

  locator.registerLazySingleton<OrderService>(
    () => OrderService(
      api: locator<Api>(),
    ),
  );

  locator.registerFactory<HomeViewModel>(() => HomeViewModel());

  locator.registerFactory<SearchFranchiseViewModel>(
    () => SearchFranchiseViewModel(
      storeService: locator<StoreService>(),
    ),
  );

  locator.registerFactory<OrderFoodStoreViewModel>(
    () => OrderFoodStoreViewModel(
      storeService: locator<StoreService>(),
      productService: locator<ProductService>(),
      orderService: locator<OrderService>(),
    ),
  );

  locator.registerFactory<OrderFoodConfirmationViewModel>(
      ()=>OrderFoodConfirmationViewModel(
        orderService: locator<OrderService>(),
      ),
  );
}

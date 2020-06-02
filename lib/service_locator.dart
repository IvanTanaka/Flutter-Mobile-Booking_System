import 'package:get_it/get_it.dart';
import 'package:member_apps/core/services/api.dart';
import 'package:member_apps/core/services/connection_service.dart';
import 'package:member_apps/core/services/news_service.dart';
import 'package:member_apps/core/services/order_service.dart';
import 'package:member_apps/core/services/product_service.dart';
import 'package:member_apps/core/services/auth_service.dart';
import 'package:member_apps/core/services/store_service.dart';
import 'package:member_apps/core/services/topup_service.dart';
import 'package:member_apps/core/services/wallet_service.dart';
import 'package:member_apps/core/viewmodels/views/home_view_model.dart';
import 'package:member_apps/core/viewmodels/views/news/news_detail_view_model.dart';
import 'package:member_apps/core/viewmodels/views/news/news_view_model.dart';
import 'package:member_apps/core/viewmodels/views/order/order_food_confirmation_view_model.dart';
import 'package:member_apps/core/viewmodels/views/order/order_food_detail_view_model.dart';
import 'package:member_apps/core/viewmodels/views/order/order_food_store_view_model.dart';
import 'package:member_apps/core/viewmodels/views/registration/login_view_model.dart';
import 'package:member_apps/core/viewmodels/views/registration/register_view_model.dart';
import 'package:member_apps/core/viewmodels/views/search_franchise_view_model.dart';
import 'package:member_apps/core/viewmodels/views/topup/topup_detail_view_model.dart';
import 'package:member_apps/core/viewmodels/views/topup/topup_history_view_model.dart';
import 'package:member_apps/core/viewmodels/views/topup/topup_home_view_model.dart';
import 'package:member_apps/core/viewmodels/views/topup/topup_view_model.dart';

import 'core/viewmodels/widgets/wallet/wallet_container_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<Api>(Api());
  locator.registerSingleton<ConnectionService>(ConnectionService());

//=========================
// GENERAL SERVICE
//=========================

  locator.registerLazySingleton<AuthService>(
    () => AuthService(
      api: locator<Api>(),
    ),
  );

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

  locator.registerLazySingleton<WalletService>(
    () => WalletService(
      api: locator<Api>(),
    ),
  );

  locator.registerLazySingleton<TopupService>(
    () => TopupService(
      api: locator<Api>(),
    ),
  );

  locator.registerLazySingleton<NewsService>(
        () => NewsService(
      api: locator<Api>(),
    ),
  );

//=========================
//  PAGE VIEWMODEL
//=========================

  locator.registerFactory<HomeViewModel>(() => HomeViewModel(
    newsService: locator<NewsService>(),
  ));

  locator.registerFactory<LoginViewModel>(
    () => LoginViewModel(
      registrationService: locator<AuthService>(),
    ),
  );

  locator.registerFactory<RegisterViewModel>(
    () => RegisterViewModel(
      registrationService: locator<AuthService>(),
    ),
  );

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
    () => OrderFoodConfirmationViewModel(
      storeService: locator<StoreService>(),
      orderService: locator<OrderService>(),
      productService: locator<ProductService>(),
    ),
  );

  locator.registerFactory<OrderFoodDetailViewModel>(
        () => OrderFoodDetailViewModel(
      orderService: locator<OrderService>(),
    ),
  );

  locator.registerFactory<TopupHomeViewModel>(
        () => TopupHomeViewModel(
      topupService: locator<TopupService>(),
    ),
  );

  locator.registerFactory<TopupHistoryViewModel>(
        () => TopupHistoryViewModel(
      topupService: locator<TopupService>(),
    ),
  );

  locator.registerFactory<TopupViewModel>(
        () => TopupViewModel(
      topupService: locator<TopupService>(),
    ),
  );

  locator.registerFactory<TopupDetailViewModel>(
        () => TopupDetailViewModel(
      topupService: locator<TopupService>(),
    ),
  );

  locator.registerFactory<NewsViewModel>(
        () => NewsViewModel(
      newsService: locator<NewsService>(),
    ),
  );

  locator.registerFactory<NewsDetailViewModel>(
        () => NewsDetailViewModel(
      newsService: locator<NewsService>(),
    ),
  );

//=========================
//  WIDGET VIEWMODEL
//=========================

  locator.registerFactory<WalletContainerViewModel>(
    () => WalletContainerViewModel(
      walletService: locator<WalletService>(),
    ),
  );
}

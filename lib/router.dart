import 'package:flutter/material.dart';
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/ui/views/news/news_detail_view.dart';
import 'package:member_apps/ui/views/news/news_favorite_view.dart';
import 'package:member_apps/ui/views/order/order_food/order_food_confirmation_view.dart';
import 'package:member_apps/ui/views/order/order_food/order_food_store_view.dart';
import 'package:member_apps/ui/views/registration/register_view.dart';
import 'package:member_apps/ui/views/search_franchise_view.dart';
import 'core/enumerations/booking_service_type.dart';
import 'ui/views/registration/login_view.dart';
import 'ui/views/main_view.dart';

class RoutePaths {
  static const String Login = "/login";
  static const String Register = "/register";
  static const String Main = "/";

  static const String NewsDetail = "/news/detail";
  static const String NewsFavorite = "/news/favorite";

  static const String SearchFranchise = "/search/Franchise";
  static const String OrderFoodStore = "/order/food/store";
  static const String OrderFoodConfirmation = "/order/food/confirmation";
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Login:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.Login),
          builder: (_) => LoginView(),
        );
      case RoutePaths.Register:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.Register),
          builder: (_) => RegisterView(),
        );
      case RoutePaths.Main:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.Main),
          builder: (_) => MainView(),
        );

      case RoutePaths.NewsDetail:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.NewsDetail),
          builder: (_) => NewsDetailView(),
        );
      case RoutePaths.NewsFavorite:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.NewsFavorite),
          builder: (_) => NewsFavoriteView(),
        );

      case RoutePaths.SearchFranchise:
        BookingServiceType serviceMenuType = settings.arguments;
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.SearchFranchise),
          builder: (_) => SearchFranchiseView(serviceMenuType: serviceMenuType),
        );

      case RoutePaths.OrderFoodStore:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.OrderFoodStore),
          builder: (_) => OrderFoodStoreView(),
        );
      case RoutePaths.OrderFoodConfirmation:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.OrderFoodConfirmation),
          builder: (_) => OrderFoodConfirmationView(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
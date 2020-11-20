import 'package:flutter/material.dart';
import 'package:member_apps/ui/views/news/news_detail_view.dart';
import 'package:member_apps/ui/views/notification/notification_view.dart';
import 'package:member_apps/ui/views/notification/notification_detail_view.dart';
import 'package:member_apps/ui/views/order/order_food/order_food_confirmation_view.dart';
import 'package:member_apps/ui/views/order/order_food/order_food_detail_view.dart';
import 'package:member_apps/ui/views/order/order_food/order_food_store_view.dart';
import 'package:member_apps/ui/views/registration/register_view.dart';
import 'package:member_apps/ui/views/restaurant/restaurant_view.dart';
import 'package:member_apps/ui/views/search_franchise_view.dart';
import 'package:member_apps/ui/views/topup/topup_detail_view.dart';
import 'package:member_apps/ui/views/topup/topup_history_view.dart';
import 'package:member_apps/ui/views/topup/topup_view.dart';
import 'ui/views/registration/login_view.dart';
import 'ui/views/main_view.dart';

class RoutePaths {
  static const String Login = "/login";
  static const String Register = "/register";
  static const String Main = "/home";

  static const String Notification = "/notification";
  static const String NotificationDetail = "/notification/detail";

  static const String NewsDetail = "/news/detail";

  static const String Restaurant = "/restaurant";

  static const String SearchFranchise = "/search/franchise";
  static const String OrderFoodStore = "/order/food/store";
  static const String OrderFoodConfirmation = "/order/food/confirmation";
  static const String OrderFoodDetail = "/order/food/detail";

  static const String Topup = "/topup";
  static const String TopupDetail = "/topup/detail";
  static const String TopupHistory = "/topup/history";
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

      case RoutePaths.Notification:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.Notification),
          builder: (_) => NotificationView(),
        );
      case RoutePaths.NotificationDetail:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.NotificationDetail),
          builder: (_) => NotificationDetailView(),
        );

      case RoutePaths.NewsDetail:
        String newsId = settings.arguments;
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.NewsDetail),
          builder: (_) => NewsDetailView(
            newsId: newsId
          ),
        );

      case RoutePaths.Restaurant:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.Restaurant),
          builder: (_) => RestaurantView(),
        );

      case RoutePaths.SearchFranchise:
        String foodCategory = settings.arguments;
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.SearchFranchise),
          builder: (_) => SearchFranchiseView(foodCategory: foodCategory),
        );

      case RoutePaths.OrderFoodStore:
        String storeId = settings.arguments;
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.OrderFoodStore),
          builder: (_) => OrderFoodStoreView(
            storeId: storeId
          ),
        );
      case RoutePaths.OrderFoodConfirmation:
        String storeId = settings.arguments;
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.OrderFoodConfirmation),
          builder: (_) => OrderFoodConfirmationView(
              storeId: storeId
          ),
        );
      case RoutePaths.OrderFoodDetail:
        String orderId = settings.arguments;
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.OrderFoodDetail),
          builder: (_) => OrderFoodDetailView(
              orderId: orderId
          ),
        );

      case RoutePaths.Topup:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.Topup),
          builder: (_) => TopupView(),
        );

      case RoutePaths.TopupDetail:
        String _topUpId = settings.arguments;
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.TopupDetail),
          builder: (_) => TopupDetailView(
            topUpId: _topUpId
          ),
        );

      case RoutePaths.TopupHistory:
        return MaterialPageRoute(
          settings: RouteSettings(name: RoutePaths.TopupHistory),
          builder: (_) => TopupHistoryView(),
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
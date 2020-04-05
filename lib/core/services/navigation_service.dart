import 'package:catcher/core/catcher.dart';

class NavigationService {


  Future<dynamic> navigateTo(String routeName, {Object arguments}) {
    return Catcher.navigatorKey.currentState.pushNamed(routeName,arguments: arguments);
  }

  Future<dynamic> navigateAndReplaceTo(String routeName, {Object arguments}) {
    return Catcher.navigatorKey.currentState.pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateAndRemoveUntil(String routeName, {Object arguments}) {
    return Catcher.navigatorKey.currentState.pushNamedAndRemoveUntil(routeName,(_)=>false, arguments: arguments);
  }

}

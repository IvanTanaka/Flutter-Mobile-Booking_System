import 'package:flutter/material.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:provider/provider.dart';

import 'router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        title: 'Membee',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: SharedColors.primaryOrangeColor,
          accentColor: SharedColors.accentColor,
          scaffoldBackgroundColor: SharedColors.scaffoldColor,
          textTheme: TextTheme(
            body1: TextStyle(
              color: SharedColors.txtColor,
            ),
          ),
        ),
        initialRoute: RoutePaths.OrderConfirmation,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}

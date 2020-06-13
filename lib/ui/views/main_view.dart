import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/views/home_view.dart';
import 'package:member_apps/ui/views/order/order_food/order_history_view.dart';
import 'package:member_apps/ui/views/topup/topup_home_view.dart';

import 'news/news_view.dart';
class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
          fixedColor: SharedColors.primaryColor,
          unselectedItemColor: SharedColors.disabledColor,
          showUnselectedLabels: true,
          currentIndex: _selectedPage,
          onTap: (int index){
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text('History'),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.newspaper),
              title: Text('News'),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.wallet),
              title: Text('Wallet'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile'),
            )
          ]
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody(){
    switch (_selectedPage){
      case 0:
        return HomeView();
      case 1:
        return OrderHistoryView();
      case 2:
        return NewsView();
      case 3:
        return TopupHomeView();
      default:
        return Container(
          color: Colors.red,
        );
    }
  }
}

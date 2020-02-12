import 'package:flutter/material.dart';
import 'package:member_apps/ui/shared_colors.dart';

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
              icon: Icon(Icons.search),
              title: Text('Search'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows),
              title: Text('Activity'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
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
      default:
        return Container(
          color: Colors.red,
        );
    }
  }
}

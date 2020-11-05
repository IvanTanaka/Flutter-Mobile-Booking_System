import 'package:flutter/material.dart';
import 'package:member_apps/ui/views/restaurant/dine_in_take_away_slider.dart';

class OrderConfirmationView extends StatefulWidget {
  @override
  _OrderConfirmationViewState createState() => _OrderConfirmationViewState();
}

class _OrderConfirmationViewState extends State<OrderConfirmationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildDineInOrTakeAway(),
          ],
        ),
      ),
    );
  }

  Widget _buildDineInOrTakeAway(){
    return Container(
      alignment: Alignment.center,
      child: DineInTakeAwaySlider(),
    );
  }
}

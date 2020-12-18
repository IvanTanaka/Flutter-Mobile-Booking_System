import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/ui/views/restaurant/widgets/dine_in_take_away_slider.dart';

class OrderConfirmationView extends StatefulWidget {
  @override
  _OrderConfirmationViewState createState() => _OrderConfirmationViewState();
}

class _OrderConfirmationViewState extends State<OrderConfirmationView> {
  DateTime _date;

  @override
  void initState() {
    _date = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pizza Hut"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildDineInOrTakeAway(),
            Divider(),
            _buildGuests(),
            Divider(),
            _buildDateTime(),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTime() {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Date",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  child: Text(_date != null ? _date.toString() : ""),
                ),
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 30)),
                    ).then((DateTime date) {
                      setState(() {
                        _date = date;
                      });
                    });
                  },
                  child: Container(
                    child: Text(_date != null ? "change" : "choose"),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Time",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  },
                  child: Container(
                    child: Text("choose"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDineInOrTakeAway() {
    return Container(
      alignment: Alignment.center,
      child: DineInTakeAwaySlider(),
    );
  }

  Widget _buildGuests() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              "Guest",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: 105,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleButton(isMinus: true),
                _buildGuestNumber(),
                _buildCircleButton(isMinus: false)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGuestNumber() {
    return Container(
      child: Text("1"),
    );
  }

  Widget _buildCircleButton({bool isMinus}) {
    return Container(
      height: 28,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4)
          ],
          color: Colors.white,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(28)),
      child: Icon(isMinus ? FontAwesomeIcons.minus : FontAwesomeIcons.plus),
    );
  }
}

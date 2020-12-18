import 'package:flutter/material.dart';
import 'package:member_apps/ui/shared_colors.dart';

class DineInTakeAwaySlider extends StatefulWidget {
  @override
  _DineInTakeAwaySliderState createState() => _DineInTakeAwaySliderState();
}

class _DineInTakeAwaySliderState extends State<DineInTakeAwaySlider>
    with SingleTickerProviderStateMixin {
  bool _toogleDineIn = true;
  double _drag = 0;
  AnimationController _controller;
  Animation<Alignment> _animation;
  Alignment _dragAlignment = Alignment.centerLeft;

  void _runAnimation() {
    _animation = _controller.drive(
      AlignmentTween(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    );
    if (!_toogleDineIn) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 50),
    );
    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _switchSize = MediaQuery.of(context).size.width / 3;
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ]),
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _switch(text: "Dine In", isDineIn: true),
              _switch(text: "Take Away", isDineIn: false)
            ],
          ),
          Container(
            alignment: _dragAlignment,
            width: (MediaQuery.of(context).size.width / 3) * 2,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  _toogleDineIn = !_toogleDineIn;
                  _runAnimation();
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  _drag = _drag + (1000 * details.delta.dx);
                  if (_drag > _switchSize / 2) {
                    _toogleDineIn = false;
                  } else {
                    _toogleDineIn = true;
                  }
                  _runAnimation();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: SharedColors.primaryOrangeColor,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.transparent,
                    )),
                width: MediaQuery.of(context).size.width / 3,
                height: 42,
                alignment: Alignment.center,
                child: Text(
                  _toogleDineIn?"Dine In":"Take Away",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _switch({String text, bool isDineIn}) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: 42,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: SharedColors.grayColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

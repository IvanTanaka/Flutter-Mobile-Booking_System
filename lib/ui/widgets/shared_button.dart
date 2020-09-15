import 'package:flutter/material.dart';
import 'package:member_apps/ui/shared_colors.dart';

class SharedButton extends StatefulWidget {
  final String text;
  final String disabledText;
  final Color activeColor;
  final Color textColor;
  final Widget child;
  final Widget preWidget;
  final Widget posWidget;
  final Function onTap;
  final double height;
  final double txtFontSize;
  final EdgeInsetsGeometry margin;
  final bool isDisabled;
  final bool isLoading;
  final bool isGoogle;

  const SharedButton(
      {Key key,
      @required this.text,
      this.disabledText,
      this.child,
      this.activeColor = SharedColors.primaryColor,
      this.preWidget,
      this.posWidget,
      this.onTap,
      this.height = 50,
      this.txtFontSize = 17,
      this.margin,
      this.isDisabled = false,
      this.isLoading = false, this.textColor, this.isGoogle})
      : super(key: key);

  @override
  _SharedButtonState createState() => _SharedButtonState();
}

class _SharedButtonState extends State<SharedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 180.0,
      margin:
          widget.margin ?? EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: RaisedButton(
        elevation: (widget.isDisabled || widget.isLoading) ? 0 : 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: (widget.isDisabled || widget.isLoading)
            ? SharedColors.btnDisabledColor
            : widget.activeColor,
        onPressed:
            (widget.isDisabled || widget.isLoading) ? null : widget.onTap,
        child: (widget.isLoading)
            ? Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(widget.activeColor),
                  ),
                ),
              )
            : Container(
                alignment: Alignment.center,
                width: 198,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    widget.preWidget ?? Container(),
                    Text(
                      (widget.isDisabled)
                          ? widget.disabledText ?? widget.text
                          : widget.text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                          color: SharedColors.btnTxtColor,
                          fontSize: widget.txtFontSize),
                    ),
                    widget.posWidget ?? Container()
                  ],
                ),
              ),
      ),
    );
  }
}

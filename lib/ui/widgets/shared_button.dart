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

  const SharedButton({
    Key key,
    @required this.text,
    this.disabledText,
    this.child,
    this.activeColor = SharedColors.primaryOrangeColor,
    this.preWidget,
    this.posWidget,
    this.onTap,
    this.height = 50,
    this.txtFontSize = 18,
    this.margin,
    this.isGoogle = false,
    this.isDisabled = false,
    this.isLoading = false,
    this.textColor = SharedColors.btnTxtColor,
  }) : super(key: key);

  @override
  _SharedButtonState createState() => _SharedButtonState();
}

class _SharedButtonState extends State<SharedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: widget.isGoogle?SharedColors.transparentGrayColor:SharedColors.transparentOrangeColor,
            blurRadius: 40,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: FlatButton(
//        elevation: (widget.isDisabled || widget.isLoading) ? 0 : 3,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.5)),
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
                          color: widget.textColor,
                          fontSize: widget.txtFontSize,
                          fontWeight: FontWeight.w700),
                    ),
                    widget.posWidget ?? Container()
                  ],
                ),
              ),
      ),
    );
  }
}

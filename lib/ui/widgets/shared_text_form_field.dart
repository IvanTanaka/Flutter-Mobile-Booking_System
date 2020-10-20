import 'package:flutter/material.dart';
import 'package:member_apps/ui/shared_colors.dart';

class SharedTextFormField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final Function(String) onChanged;
  final Function(String) validator;
  final Widget suffixIcon;
  final TextEditingController controller;

  const SharedTextFormField(
      {Key key,
      this.validator,
      this.hintText = "",
      this.suffixIcon,
      this.obscureText = false,
      this.onChanged,
      this.controller})
      : super(key: key);

  @override
  _SharedTextFormFieldState createState() => _SharedTextFormFieldState();
}

class _SharedTextFormFieldState extends State<SharedTextFormField> {
  String _errorMessage;
  bool _errorState = false;
  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        if(_focusNode.hasFocus){
          _errorMessage = null;
          _errorState = false;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          validator: (String value) {
            setState(() {
              _errorMessage = widget.validator(value);
              _errorState = _errorMessage.isNotEmpty;
            });
            return null;
          },
          cursorColor: SharedColors.primaryColor,
          obscureText: widget.obscureText,
          onChanged: (String value) {
            setState(() {});
            widget.onChanged(value);
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 27),
            labelText: widget.hintText,
            suffixIcon: widget.suffixIcon,
            labelStyle: TextStyle(
                color: _focusNode.hasFocus
                    ? SharedColors.primaryOrangeColor
                    : SharedColors.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 18),
            filled: true,
            fillColor: Colors.white70,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(
                  color: SharedColors.primaryOrangeColor, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(
                  color: widget.controller.text == ""
                      ? _errorState?SharedColors.errorColor:SharedColors.blackColor
                      : SharedColors.primaryOrangeColor,
                  width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(
                  color: SharedColors.primaryOrangeColor, width: 1.5),
            ),
          ),
        ),
        Container(
          height: 5,
        ),
        Container(
          height: 16,
          child: Row(
            children: [
              _errorState?Icon(Icons.error_outline, color: SharedColors.errorColor, size: 16,):Container(),
              Container(width: 5,),
              Text(
                _errorMessage ?? " ",
                style: TextStyle(
                  fontSize: 14,
                  color: SharedColors.errorColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

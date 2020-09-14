import 'package:flutter/material.dart';
import 'package:member_apps/ui/shared_colors.dart';

class SharedTextFormField extends StatefulWidget {
  final Function(String) validator;
  final String hintText;
  final bool obscureText;
  final ChangedCallback onChanged;

  const SharedTextFormField({Key key, this.validator, this.hintText = "", this.obscureText =false, this.onChanged}) : super(key: key);


  @override
  _SharedTextFormFieldState createState() => _SharedTextFormFieldState();

}

class _SharedTextFormFieldState extends State<SharedTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String value) {
        return widget.validator(value);
      },
      cursorColor: SharedColors.primaryColor,
      obscureText: widget.obscureText,
      onChanged: (String value){
        widget.onChanged(value);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 27, top: 20,bottom: 13),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: SharedColors.primaryOrangeColor, fontWeight: FontWeight.w700, fontSize: 18),
        filled: true,
        fillColor: Colors.white70,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: SharedColors.primaryOrangeColor, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: SharedColors.primaryOrangeColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: SharedColors.primaryOrangeColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: SharedColors.primaryOrangeColor, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: SharedColors.primaryOrangeColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: SharedColors.primaryOrangeColor),
        ),
      ),
    );
  }
}

typedef ChangedCallback = void Function(String value);

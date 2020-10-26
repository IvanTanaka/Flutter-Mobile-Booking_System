import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_button.dart';
import 'package:member_apps/ui/widgets/shared_text_form_field.dart';
import 'package:badges/badges.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SharedColors.whiteColor,
      appBar: AppBar(
        backgroundColor: SharedColors.whiteColor,
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 4),
            child: Card(
              child: ListTile(
                onTap: () {},
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      'Time',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: SharedColors.grayColor,
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  'Subtitle',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,

                  ),
                ),
                leading: Badge(
                  padding: EdgeInsets.all(3),
                  badgeContent: Badge(

                    badgeContent: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Text(''),
                    ),
                    badgeColor: SharedColors.badgeColor,
                  ),
                  badgeColor: SharedColors.whiteColor,
                  position: BadgePosition.topEnd(top: -14, end: 16),
                  elevation: 0,
                  child: RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: SharedColors.primaryOrangeColor,
                    child: Icon(
                      FontAwesomeIcons.envelope,
                      size: 25.0,
                      color: SharedColors.whiteColor,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                )
                ),
              ),
            );
        },
      ),
    );
  }
}

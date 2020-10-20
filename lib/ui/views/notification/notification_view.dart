import 'dart:ui';

import 'package:flutter/material.dart';
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
                title: Text('Title'),
                subtitle: Text('Subtitle'),
                leading: Badge(
                  badgeContent: Text(''),
                  badgeColor: Colors.yellow,
                  position: BadgePosition(top: 0, end: 15),
                  child: RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: SharedColors.primaryOrangeColor,
                    child: Icon(
                      Icons.mail,
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

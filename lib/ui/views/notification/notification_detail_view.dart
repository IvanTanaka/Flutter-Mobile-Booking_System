import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';


class NotificationDetailView extends StatefulWidget {
  @override
  _NotificationDetailViewState createState() => _NotificationDetailViewState();
}

class _NotificationDetailViewState extends State<NotificationDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Restaurant Name',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }
}

class _buildBody extends StatelessWidget {
  const _buildBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20,25,19,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lorem Ipsum',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Fri, 1 January 20 20:20',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 19),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(
                  'https://post.healthline.com/wp-content/uploads/2020/09/healthy-eating-ingredients-1200x628-facebook-1200x628.jpg'
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis et arcu ligula. Mauris efficitur urna vitae vestibulum sollicitudin. Curabitur tincidunt sem sed porttitor mollis. Pellentesque ut eros elit. In accumsan nulla aliquam orci luctus auctor. In ante leo, sagittis in bibendum ac, consectetur sed mauris. Phasellus non magna quis metus sodales molestie et et neque. Curabitur at rutrum augue. Vestibulum facilisis, dolor ut lobortis sollicitudin, massa leo laoreet augue, ac congue est tellus id lectus.',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ],
        ),

      ),
    );
    Container(
      child: Text(
        'Date'
      ),
    );
  }
}

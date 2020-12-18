import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RestaurantView extends StatefulWidget {
  @override
  _RestaurantViewState createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 335,
                collapsedHeight: 120,
                floating: false,
                pinned: true,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  centerTitle: true,
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Restaurant",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 17,
                          ),
                          Text(
                            '1.2 km',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      new Container(
                        height: 40.0,
                        child: new ListView(
                          scrollDirection: Axis.horizontal,
                          children: new List.generate(10, (int index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: new FlatButton(
                                child: Text(
                                  'Menu',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: SharedColors.grayColor),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    side: BorderSide(
                                        color: SharedColors.primaryBlue)),
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                  background: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 245,
                        width: double.infinity,
                        child: Image.network(
                          "https://static.toiimg.com/thumb/56933159.cms?imgsize=686279&width=800&height=800",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Container(
                        height: 60,
                      ),
                    ],
                  ),
                ),
                leading: new Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.transparent)),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.transparent)),
                      child: Center(
                        child: Text(
                          'i',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ];
          },
          body: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                    onTap: () {},
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Food Name',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Food Description',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rp 10.000',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: SharedColors.primaryBlue,
                          ),
                        ),
                        FlatButton(
                          color: SharedColors.primaryBlue,
                          disabledColor: SharedColors.primaryBlue,
                          child: Text(
                            'Add',
                            style: TextStyle(
                                fontSize: 16, color: SharedColors.whiteColor),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side:
                                  BorderSide(color: SharedColors.primaryBlue)),
                        ),
                      ],
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image(
                        width: 88,
                        height: 88,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://shopsquareone.com/sites/default/files/assets/content/reds_restaurants_mississauga_ontario.jpg'),
                      ),
                    )),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 372,
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2 items',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 16),
                  ),
                  Text(
                    'Restaurant',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 14),
                  ),
                ],
              ),
              Container(width: 130,),
              Text(
                'Rp 10.000',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700,fontSize: 18),
              ),
            ],
          ),
          icon: Icon(
            FontAwesomeIcons.shoppingBasket,
            color: Colors.white,
          ),
          backgroundColor: SharedColors.badgeColor,
        ),
      ),
    );
  }
}

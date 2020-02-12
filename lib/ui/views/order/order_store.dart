import 'package:flutter/material.dart';
import 'package:member_apps/ui/prototype_constant.dart';
import 'package:member_apps/ui/shared_colors.dart';

class OrderStore extends StatefulWidget {
  @override
  _OrderStoreState createState() => _OrderStoreState();
}

class _OrderStoreState extends State<OrderStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: SharedColors.scaffoldColor,
        centerTitle: true,
        title: Stack(
          children: <Widget>[
            Container(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Balance",
                    style: Theme.of(context).textTheme.caption.merge(
                          TextStyle(
                            color: SharedColors.primaryColor,
                          ),
                        ),
                  ),
                  Text(
                    "Rp 12.000",
                    style: Theme.of(context).textTheme.title,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        children: <Widget>[
          _buildStoreTop(),
          _buildStoreTab(),
        ],
      ),
    );
  }

  Widget _buildStoreTop() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  NetworkImage(PrototypeConstant.FRANCHISE_PROFILE_IMAGE),
            ),
            Container(
              height: 5,
            ),
            Container(
              child: Text("Golden Lamian", style: TextStyle(fontWeight: FontWeight.w500),),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStoreTab(){
    return Container();
  }
}

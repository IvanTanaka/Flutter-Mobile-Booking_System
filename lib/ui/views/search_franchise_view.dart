import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/search_store_model.dart';
import 'package:member_apps/core/viewmodels/views/search_franchise_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_loading_page.dart';

class SearchFranchiseView extends StatefulWidget {
  final String foodCategory;

  const SearchFranchiseView({Key key, this.foodCategory}) : super(key: key);

  @override
  _SearchFranchiseViewState createState() => _SearchFranchiseViewState();
}

class _SearchFranchiseViewState extends State<SearchFranchiseView> {
  TextEditingController _searchController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  SearchFranchiseViewModel _viewModel = locator<SearchFranchiseViewModel>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        await _viewModel.getMoreStoreByName(_searchController.text);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SearchFranchiseViewModel>(
      model: _viewModel,
      onModelReady: (SearchFranchiseViewModel viewModel) {
        viewModel.food_category = widget.foodCategory;
        viewModel.searchStoreModel = [];
      },
      builder: (BuildContext context, SearchFranchiseViewModel viewModel,
          Widget child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 1,
              backgroundColor: SharedColors.scaffoldColor,
              title: Text(
                "Search Restaurant",
              ),
            ),
            body: _buildBody());
      },
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: _buildSearchBar(),
          ), Expanded(
                  child:
                  (_viewModel.searchStoreModel.length == 0)
                      ? _buildEmptyContainer()
                      :(_viewModel.busy)
                      ? SharedLoadingPage()
                      : _buildStoreList())
        ],
      ),
    );
  }

  Widget _buildEmptyContainer() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/search_empty.png"),
            Container(
              child: Text(
                'Sorry, restaurant not found.',
                style: TextStyle(
                    fontSize: 20,
                    color: SharedColors.btnDisabledColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(height: 120,),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreList() {
    return ListView.separated(
      controller: _scrollController,
      itemCount: _viewModel.searchStoreModel.length + 1,
      itemBuilder: (BuildContext context, int index) {
        return (index == _viewModel.searchStoreModel.length)
            ? Container(
                height: 50,
                child: (_viewModel.listIsUpdate)
                    ? SharedLoadingPage()
                    : Container(),
              )
            : _buildStoreContainer(_viewModel.searchStoreModel[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
            indent: 0, endIndent: 0, color: SharedColors.accentColor);
      },
    );
  }

  Widget _buildStoreContainer(SearchStoreModel model) {
    return GestureDetector(
      onTap: () {
        if (!model.haveBranches) {
          _navigateToStorePage(model.branchId);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 5),
        color: Colors.transparent,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 10,
                ),
                child: Text(
                  model.franchiseName,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
              (model.ratingStars!=null)?Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text(
                        model.ratingStars,
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ),
                    Icon(Icons.star, color: SharedColors.statusWaiting, size: 16,)
                  ],
                ),
              ):Container(),
              (!model.haveBranches)
                  ? Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: <Widget>[
                          _buildBranchAddress(model.address),
                          Container(
                            height: 5,
                          ),
                          _buildBranchPhoneNumber(model.phoneNumber),
                        ],
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        ListView.separated(
                          itemCount: model.branches.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return _buildBranchContainer(model.branches[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                                indent: 0,
                                endIndent: 0,
                                color: SharedColors.accentColor);
                          },
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBranchContainer(BranchModel model) {
    return GestureDetector(
      onTap: () {
        _navigateToStorePage(model.id);
      },
      child: Container(
        padding: EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 15),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                model.name,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ),
            Container(
              height: 5,
            ),
            _buildBranchAddress(model.address),
            Container(
              height: 5,
            ),
            _buildBranchPhoneNumber(model.phoneNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchAddress(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          FontAwesomeIcons.mapMarker,
          size: 12,
          color: SharedColors.primaryColor,
        ),
        Container(
          width: 10,
        ),
        Expanded(
          child: Container(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBranchPhoneNumber(String text) {
    return Row(
      children: <Widget>[
        Icon(
          FontAwesomeIcons.phone,
          size: 12,
          color: SharedColors.primaryColor,
        ),
        Container(
          width: 10,
        ),
        Container(
          child: Text("+6282272675309"),
        ),
      ],
    );
  }

  void _navigateToStorePage(String id) {
    Navigator.pushNamed(context, RoutePaths.OrderFoodStore, arguments: id);
  }

  Widget _buildSearchBar() {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: SharedColors.accentColor, width: 3)),
        child: TextField(
          textInputAction: TextInputAction.search,
          cursorColor: Colors.black,
          onSubmitted: (String value) async {
            await _viewModel.getStoreByName(value);
          },
          controller: _searchController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search restaurant name",
              prefixIcon: Icon(Icons.search)),
        ),
      ),
    );
  }
}

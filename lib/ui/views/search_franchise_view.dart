import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/search_store_model.dart';
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/viewmodels/views/search_franchise_view_model.dart';
import 'package:member_apps/router.dart';
import 'package:member_apps/service_locator.dart';
import 'package:member_apps/ui/shared_colors.dart';
import 'package:member_apps/ui/widgets/shared_loading_page.dart';

class SearchFranchiseView extends StatefulWidget {
  final ServiceMenuType serviceMenuType;

  const SearchFranchiseView({Key key, this.serviceMenuType}) : super(key: key);

  @override
  _SearchFranchiseViewState createState() => _SearchFranchiseViewState();
}

class _SearchFranchiseViewState extends State<SearchFranchiseView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<SearchFranchiseViewModel>(
      model: locator<SearchFranchiseViewModel>(),
      onModelReady: (SearchFranchiseViewModel viewModel) {
        viewModel.type = widget.serviceMenuType;
      },
      builder: (BuildContext context, SearchFranchiseViewModel viewModel,
          Widget child) {
        return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: SharedColors.scaffoldColor,
              title: Text(
                viewModel.searchPageTitle,
              ),
            ),
            body: _buildBody(viewModel));
      },
    );
  }

  Widget _buildBody(SearchFranchiseViewModel viewModel) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: _buildSearchBar(viewModel),
          ),
          Expanded(
              child: (viewModel.busy)
                  ? SharedLoadingPage()
                  : _buildStoreList(viewModel))
        ],
      ),
    );
  }

  Widget _buildStoreList(SearchFranchiseViewModel viewModel) {
    return ListView.separated(
      itemCount: viewModel.searchStoreModel.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildStoreContainer(viewModel, viewModel.searchStoreModel[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
            indent: 0, endIndent: 0, color: SharedColors.accentColor);
      },
    );
  }

  Widget _buildStoreContainer(SearchFranchiseViewModel viewModel,SearchStoreModel model) {
    return GestureDetector(
      onTap: () {
        if (!model.haveBranches){
          _navigateToStorePage(viewModel, model.id);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 10),
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
                            return _buildBranchContainer(viewModel, model.branches[index]);
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
    ;
  }

  Widget _buildBranchContainer(SearchFranchiseViewModel viewModel, BranchModel model) {
    return GestureDetector(
      onTap: (){
        _navigateToStorePage(viewModel, model.id);
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
                "Cab. index",
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
            child: Text(text, overflow: TextOverflow.ellipsis, maxLines: 3,),
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

  void _navigateToStorePage(SearchFranchiseViewModel viewModel, String id){
    viewModel.getStore(id);
    Navigator.pushNamed(context, RoutePaths.OrderStore);
  }

  Widget _buildSearchBar(SearchFranchiseViewModel viewModel) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(3),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
        ),
        child: TextFormField(
          textInputAction: TextInputAction.search,
          cursorColor: Colors.black,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: viewModel.searchPagePlaceholder,
              prefixIcon: Icon(Icons.search)),
        ),
      ),
    );
  }
}

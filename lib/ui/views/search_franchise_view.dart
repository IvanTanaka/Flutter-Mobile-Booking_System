import 'package:flutter/material.dart';
import 'package:member_apps/base_widget.dart';
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/viewmodels/views/search_franchise_view_model.dart';
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
          Expanded(child: (viewModel.busy)?SharedLoadingPage():_buildStoreList(viewModel))
        ],
      ),
    );
  }

  Widget _buildStoreList(SearchFranchiseViewModel viewModel){
    return ListView.builder(itemCount: 10,itemBuilder: (BuildContext context, int index){
      return _buildStoreContainer();
    });
  }


  Widget _buildStoreContainer(){
    return Container();
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
            prefixIcon: Icon(Icons.search)
          ),
        ),
      ),
    );
  }
}

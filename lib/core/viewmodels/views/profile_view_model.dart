import 'package:member_apps/core/models/user_model.dart';
import 'package:member_apps/core/services/auth_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class ProfileViewModel extends BaseViewModel {
  AuthService _authService;
  UserModel userModel;

  ProfileViewModel({AuthService authService}){
    this._authService = authService;
  }

  Future loadUser() async {
    setBusy(true);
    userModel = await _authService.loadUser();
    setBusy(false);
  }

  Future logout() async{
    setBusy(true);
    await _authService.logout();
    setBusy(false);
  }

}
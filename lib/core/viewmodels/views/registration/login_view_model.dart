import 'package:member_apps/core/services/auth_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends BaseViewModel {

  AuthService _authService;
  String email;
  String password;
  String emailErrorMessage, passwordErrorMessage;

  BehaviorSubject<String> _errorMessageController = BehaviorSubject<String>();
  Stream<String> get errorMessageStream => _errorMessageController.stream;
  Future<bool> get isLogin async => await _authService.isLogin;
  LoginViewModel({AuthService registrationService}){
    this._authService = registrationService;
  }

  String validateEmail(String value){
    bool validEmail =  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if(value.length<=0){
      return "Please enter your email";
    }
    if(!validEmail){
      return "Email is not valid";
    }
    this.email = value;
    return null;
  }

  

  String validatePassword(String value){
    if(value.length<=0){
      return "Please enter your password";
    }
    this.password = value;
    return null;
  }

  Future<bool> loginUser() async {
    setBusy(true);
    try {
      _errorMessageController.drain();
      bool login = await _authService.login(
          email: email,
          password: password
      );
      setBusy(false);
      return login;
    }catch(exception){
      _errorMessageController.add(exception.toString());
      setBusy(false);
      throw exception;
    }
  }
}
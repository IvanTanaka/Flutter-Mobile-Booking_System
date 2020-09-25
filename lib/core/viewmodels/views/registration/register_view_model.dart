import 'package:member_apps/core/services/auth_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';
import 'package:rxdart/rxdart.dart';

class RegisterViewModel extends BaseViewModel {

  AuthService _authService;
  String name;
  String email;
  String phoneNumber;
  String password;
  String confirmPassword;

  BehaviorSubject<String> _errorMessageController = BehaviorSubject<String>();
  Stream<String> get errorMessageStream => _errorMessageController.stream;

  Future<bool> get isLogin  async => await _authService.isLogin;

  RegisterViewModel({AuthService registrationService}){
    this._authService = registrationService;
  }

  @override
  dispose(){
    _errorMessageController.close();
    super.dispose();
  }

  String validateName(String value){
    if(value.length<=0){
      return "Name must not be empty";
    }
    this.name = value;
    return null;
  }

  String validateEmail(String value){
    bool validEmail =  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if(value.length<=0){
      return "Email must not be empty";
    }
    if(!validEmail){
      return "Email is not valid";
    }
    this.email = value;
    return null;
  }
  String validatePhoneNumber(String value){
    if(value.length<=0){
      return "Phone number must not be empty";
    }
//    final phoneRegex = RegExp(r'\+?([ -]?\d+)+|\(\d+\)([ -]\d+)');
    final phoneRegex = RegExp(r'(\+62)+([ -]?\d)+|(\(061\))+([ -]?\d)+');
    if(phoneRegex.stringMatch(value)!=value){
      return "Please input a correct format";
    }
    this.phoneNumber = value;
    return null;
  }
  String validatePassword(String value){
    if(value.length<=0){
      return "Password must not be empty";
    }
    if(value.length<6){
      return "Password must be at least 6 characters";
    }
    this.password = value;
    return null;
  }

  String validateConfirmPassword(String value){
    if(value.length<=0){
      return "Confirm password must not be empty";
    }
    if(value != password){
      return "Password and confirm password must be the same";
    }
    this.confirmPassword = value;
    return null;
  }

  Future<bool> registerUser() async {
    setBusy(true);
    try {
      _errorMessageController.drain();
      bool register = await _authService.register(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          password: password
      );
      setBusy(false);
      return register;
    }catch(exception){
      _errorMessageController.add(exception.toString());
      setBusy(false);
      return false;
    }
  }
}
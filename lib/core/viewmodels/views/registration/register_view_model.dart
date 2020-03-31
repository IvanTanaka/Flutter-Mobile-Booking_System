import 'package:member_apps/core/services/registration_service.dart';
import 'package:member_apps/core/viewmodels/base_view_model.dart';

class RegisterViewModel extends BaseViewModel {

  RegistrationService _registrationService;
  String name;
  String email;
  String phoneNumber;
  String password;
  String confirmPassword;

  RegisterViewModel({RegistrationService registrationService}){
    this._registrationService = registrationService;
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
    this.phoneNumber = value;
    return null;
  }
  String validatePassword(String value){
    if(value.length<=0){
      return "Name must not be empty";
    }
    if(value.length<6){
      return "Password must be at least 6 characters";
    }
    if(value != confirmPassword){
      return "Password and confirm password must be the same";
    }
    this.password = value;
    return null;
  }

  Future<bool> registerUser() async {
    setBusy(true);
    bool register = await _registrationService.register(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      password: password
    );
    setBusy(false);
    return register;
  }
}
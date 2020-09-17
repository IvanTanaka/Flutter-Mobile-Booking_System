import 'package:member_apps/core/viewmodels/views/registration/login_view_model.dart';
import 'package:test/test.dart';

void main() {
  final viewModel = LoginViewModel();
  String email = 'abc@gmail.com';
  String randomString = 'asdadasda';
  String errorNotValid = 'Email is not valid';
  String errorEmailNotEmpty = 'Email must not be empty';
  String errorPasswordNotEmpty = 'Password must not be empty';
  String empty = '';
  test('Validating email using right email structure expected pass', () {
    var result = viewModel.validateEmail(email);
    expect(result, null);
  });

  test('Validating email using wrong email structure expected error', () {
    var result = viewModel.validateEmail(randomString);
    expect(result, errorNotValid);
  });

  test('Validating email using empty string expected error', () {
    var result = viewModel.validateEmail(empty);
    expect(result, errorEmailNotEmpty);
  });

  test('Validating password using random string expected pass', () {
    var result = viewModel.validatePassword(randomString);
    expect(result, null);
  });

  test('Validating password using empty string expected error', () {
    var result = viewModel.validatePassword(empty);
    expect(result, errorPasswordNotEmpty);
  });

  test('Login User using valid email and password expected pass', () {
    viewModel.loginUser();
  });
}

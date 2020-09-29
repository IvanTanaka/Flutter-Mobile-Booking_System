import 'package:member_apps/core/services/auth_service.dart';
import 'package:member_apps/core/viewmodels/views/registration/register_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements AuthService {}

void main() {
  final client = MockClient();
  final viewModel = RegisterViewModel();
  String dummyEmail = 'abc@gmail.com';
  String randomString = 'adsasdas';
  String password5Chara = 'asdfg';
  String phoneNumber = '0813740182';
  String empty = '';
  String expectedEmpty = 'Email must not be empty';
  String expectedNotValid = 'Email is not valid';
  String expectedNameEmpty = 'Name must not be empty';
  String errorPasswordNotEmpty = 'Password must not be empty';
  String errorPasswordMustBeSix = 'Password must be at least 6 characters';
  test('Validating email on register, expected pass', () {
    var result = viewModel.validateEmail(dummyEmail);
    expect(result, isNull);
  });
  test('Validating email on register, expected error email empty', () {
    var result = viewModel.validateEmail(empty);
    expect(result, expectedEmpty);
  });
  test('Validating email on register, expected error email not valid', () {
    var result = viewModel.validateEmail(randomString);
    expect(result, expectedNotValid);
  });
  test('Validating name on register , expected pass', () {
    var result = viewModel.validateName(randomString);
    expect(result, isNull);
  });
  test('Validating name on register, expected error name empty', () {
    var result = viewModel.validateName(empty);
    expect(result, expectedNameEmpty);
  });
  test('Validating password on register , expected pass', () {
    var result = viewModel.validatePassword(randomString);
    expect(result, isNull);
  });
  test('Validating password on register, expected error password empty', () {
    var result = viewModel.validatePassword(empty);
    expect(result, errorPasswordNotEmpty);
  });
  test(
      'Validating password on register, expected error password must be 6 characters',
      () {
    var result = viewModel.validatePassword(password5Chara);
    expect(result, errorPasswordMustBeSix);
  });

//command
  test('Registering user using mockito,expected pass', () async {
    var futureBool = true;
    when(client.register(
            email: dummyEmail,
            password: randomString,
            name: randomString,
            phoneNumber: phoneNumber))
        .thenAnswer((_) async => futureBool);
    var result = await client.register(
        email: dummyEmail,
        password: randomString,
        name: randomString,
        phoneNumber: phoneNumber);
    expect(result, futureBool);
  });

  test('Registering user using mockito without expected var, expected error',
      () async {
    var futureBool = true;
    when(client.register(
            email: dummyEmail,
            password: randomString,
            name: randomString,
            phoneNumber: phoneNumber))
        .thenAnswer((_) async => futureBool);
    var result = await client.register(
        email: dummyEmail,
        password: randomString,
        name: randomString,
        phoneNumber: empty);
    AssertionError(result);
  });
}

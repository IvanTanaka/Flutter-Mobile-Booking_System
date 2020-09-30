import 'dart:convert';

import 'package:member_apps/core/models/user_model.dart';
import 'package:member_apps/core/services/auth_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements AuthService {}

void main() {
  final client = MockClient();
  var user = {
    "name": "Vincent",
    "email": "123@gmail.com",
    "phonenumber": "081720740127"
  };
  UserModel userModel = UserModel.fromJson(user);
  test('Mock login user, expected return user', () async {
    when(client.loadUser()).thenAnswer((_) async => userModel);
    var result = await client.loadUser();
    expect(result.name, userModel.name);
  });
}

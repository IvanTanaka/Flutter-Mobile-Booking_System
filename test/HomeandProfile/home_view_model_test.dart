import 'dart:convert';

import 'package:member_apps/core/models/franchise_model.dart';
import 'package:member_apps/core/models/news_model.dart';
import 'package:member_apps/core/services/news_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements NewsService {}

void main() {
  final client = MockClient();
  var newsJson = {
    "id": "123asd",
    "franchiseId": "12313",
    "imagePath": "http://10.0.2.2:8000/_Images",
    "description": "asd",
    "franchise": FranchiseModel().toJson()
  };
  List<NewsModel> listNewsModel = [NewsModel.fromJson(newsJson)];
  test('Test news load function , expected news', () async {
    when(client.loadNews()).thenAnswer((_) async => listNewsModel);
    var result = await client.loadNews();
    expect(result[0].description, listNewsModel[0].description);
  });
}

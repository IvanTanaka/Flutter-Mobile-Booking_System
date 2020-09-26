import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/franchise_model.dart';
import 'package:member_apps/core/models/news_detail_model.dart';
import 'package:member_apps/core/services/news_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements NewsService {}

void main() {
  final client = MockClient();
  final franchise = FranchiseModel();
  final branchModel = BranchModel();
  var dummyNews = "123";
  var newsDetail = {
    "id": "123",
    "franchiseId": "123asd",
    "imagePath": "storage/images/news/imagePath",
    "description": "sdasdasd",
    "franchise": franchise.toJson(),
    "branches": [branchModel.toJson()]
  };

  NewsDetailModel newsDetailModel = NewsDetailModel.fromJson(newsDetail);
  test("testing news detail function, expected return news detail", () async {
    when(client.loadNewsDetail(newsId: dummyNews))
        .thenAnswer((_) async => newsDetailModel);
    var result = await client.loadNewsDetail(newsId: dummyNews);
    expect(result.id, newsDetailModel.id);
  });

  test("testing news detail function, expected return error", () async {
    when(client.loadNewsDetail(newsId: dummyNews))
        .thenAnswer((_) async => newsDetailModel);
    var result = await client.loadNewsDetail(newsId: null);
    AssertionError(result);
  });
}

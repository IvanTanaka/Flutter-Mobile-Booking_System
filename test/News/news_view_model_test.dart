import 'package:member_apps/core/models/franchise_model.dart';
import 'package:member_apps/core/models/news_model.dart';
import 'package:member_apps/core/services/news_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements NewsService {}

void main() {
  final client = MockClient();
  var news = {
    "id": "123asd",
    "franchiseId": "12313",
    "imagePath": "http://10.0.2.2:8000/_Images",
    "description": "asd",
    "franchise": FranchiseModel().toJson()
  };
  List<NewsModel> nm = [NewsModel.fromJson(news)];
  test('Testing loadnews function on news viewmodel', () async {
    when(client.loadNews()).thenAnswer((_) async => nm);
    var result = await client.loadNews();
    expect(result[0].description, nm[0].description);
  });
}

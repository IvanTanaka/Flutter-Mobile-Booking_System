import 'dart:convert';

import 'package:member_apps/core/constants/network_code.dart';
import 'package:member_apps/core/models/news_detail_model.dart';
import 'package:member_apps/core/models/news_model.dart';
import 'package:member_apps/core/services/api.dart';

class NewsService{

  Api _api;
  List<NewsModel> news = [];
  int page=1;

  NewsService({Api api}){
    this._api =api;
  }

  Future<List<NewsModel>> loadNews() async{
    final response = await _api.get(
      url:
      "v1/news?page=$page",
    );
    final resDecoded = json.decode(response);
    if(resDecoded["code"]==NetworkCode.SUCCESS){
      page++;
      this.news.addAll(List<NewsModel>.from(resDecoded["result"]["data"].map((x) => NewsModel.fromJson(x))));
      return news;
    }
    return this.news;
  }

  Future<NewsDetailModel> loadNewsDetail({String newsId}) async{
    final response = await _api.get(
      url:
      "v1/news/$newsId",
    );
    final resDecoded = json.decode(response);
    if(resDecoded["code"]==NetworkCode.SUCCESS){
      return NewsDetailModel.fromJson(resDecoded["result"]);
    }
    return NewsDetailModel();
  }
}
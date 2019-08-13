import 'dart:convert';

import 'package:my_project_name/Webservice.dart';
import 'package:my_project_name/utils/Constants.dart';

class NewsArticle {
  final String title;
  final String descrption;
  final String urlToImage;

  NewsArticle({this.title, this.descrption, this.urlToImage});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
        title: json['title'],
        descrption: json['description'],
        urlToImage:
            json['urlToImage'] ?? Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL);
  }

  static Resource<List<NewsArticle>> get all {
    return Resource(
        url: Constants.HEADLINE_NEWS_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result['articles'];
          return list.map((model) => NewsArticle.fromJson(model)).toList();
        });
  }
}

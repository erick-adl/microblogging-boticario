import 'package:flutter/material.dart';
import 'package:microblogging/core/usecases/usecase.dart';

import 'package:microblogging/features/news/domain/entities/news_entity.dart';

import 'package:microblogging/features/news/domain/usecases/get_news.dart';

class NewsManager extends ChangeNotifier {
  final GetNews getNews;

  NewsManager({
    @required GetNews getNews,
  })  : assert(getNews != null),
        getNews = getNews {
    _loadNews();
  }

  List<News> newsList = [];

  Future<void> _loadNews() async {
    loading = true;
    final news = await getNews(NoParams());

    news.fold(
      (failure) {
        loading = false;
      },
      (date) => newsList = date.news,
    );

    loading = false;
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}

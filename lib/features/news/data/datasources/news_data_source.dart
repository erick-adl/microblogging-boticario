import 'package:dio/dio.dart';

import 'package:meta/meta.dart';
import 'package:microblogging/features/news/domain/entities/news_entity.dart';

import '../../../../core/error/exceptions.dart';

abstract class INewsDataSource {
  Future<NewsEntity> getNews();
}

class NewsDataSource implements INewsDataSource {
  final Dio dio;

  NewsDataSource({@required this.dio});

  @override
  Future<NewsEntity> getNews() async {
    final response = await dio.get(
      "https://gb-mobile-app-teste.s3.amazonaws.com/data.json",
    );

    if (response.statusCode == 200) {
      final result = NewsEntity.fromJson(response.data);

      return result;
    } else {
      throw ServerException();
    }
  }
}

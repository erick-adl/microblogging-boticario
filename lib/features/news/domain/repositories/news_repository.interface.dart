import 'package:dartz/dartz.dart';
import 'package:microblogging/core/error/failures.dart';
import 'package:microblogging/features/news/domain/entities/news_entity.dart';

abstract class INewsRepository {
  Future<Either<Failure, NewsEntity>> getNews();
}

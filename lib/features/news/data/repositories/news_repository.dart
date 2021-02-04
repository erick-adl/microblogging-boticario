import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';
import 'package:microblogging/features/news/data/datasources/news_data_source.dart';

import 'package:microblogging/features/news/domain/entities/news_entity.dart';

import 'package:microblogging/features/news/domain/repositories/news_repository.interface.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

class NewsRepository implements INewsRepository {
  final INewsDataSource newsDataSource;

  final NetworkInfo networkInfo;

  NewsRepository({
    @required this.newsDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NewsEntity>> getNews() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNewsList = await newsDataSource.getNews();

        return Right(remoteNewsList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}

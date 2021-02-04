import 'package:dartz/dartz.dart';
import 'package:microblogging/core/error/failures.dart';
import 'package:microblogging/core/usecases/usecase.dart';
import 'package:microblogging/features/news/domain/entities/news_entity.dart';

import 'package:microblogging/features/news/domain/repositories/news_repository.interface.dart';

class GetNews implements UseCase<NewsEntity, NoParams> {
  final INewsRepository repository;

  GetNews(this.repository);

  @override
  Future<Either<Failure, NewsEntity>> call(NoParams params) async {
    return await repository.getNews();
  }
}

import 'package:dartz/dartz.dart';
import 'package:microblogging/core/usecases/usecase.dart';

import 'package:microblogging/features/news/domain/entities/news_entity.dart';

import 'package:microblogging/features/news/domain/repositories/news_repository.interface.dart';
import 'package:microblogging/features/news/domain/usecases/get_news.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNesRepository extends Mock implements INewsRepository {}

void main() {
  GetNews usecase;
  MockNesRepository mockNewsRepository;

  setUp(() {
    mockNewsRepository = MockNesRepository();
    usecase = GetNews(mockNewsRepository);
  });

  final NewsEntity newsList = NewsEntity();
  test(
    'should get a list of news from repository',
    () async {
      // arrange
      when(mockNewsRepository.getNews())
          .thenAnswer((_) async => Right(newsList));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(newsList));
      verify(mockNewsRepository.getNews());
      verifyNoMoreInteractions(mockNewsRepository);
    },
  );
}

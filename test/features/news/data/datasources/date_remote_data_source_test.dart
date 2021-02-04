import 'package:dio/dio.dart';
import 'package:microblogging/core/error/exceptions.dart';
import 'package:microblogging/features/news/data/datasources/news_data_source.dart';
import 'package:microblogging/features/news/domain/entities/news_entity.dart';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  NewsDataSource dataSource;
  MockDio mockDio;
  final tResponseSuccess =
      Response(statusCode: 200, data: fixture('news.json'));
  final tResponseError = Response(
    statusCode: 404,
  );

  setUp(() {
    mockDio = MockDio();
    dataSource = NewsDataSource(dio: mockDio);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockDio.get(
      any,
    )).thenAnswer((Invocation invocation) async => tResponseSuccess);
  }

  void setUpMockHttpClientFailure404() {
    when(mockDio.get(any))
        .thenAnswer((Invocation invocation) async => tResponseError);
  }

  group('get news', () {
    final newsEntity = newsModelFromJson(fixture('news.json'));

    test(
      '''should perform a GET request on a URL  with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getNews();
        // assert
        verify(mockDio.get(
          'https://gb-mobile-app-teste.s3.amazonaws.com/data.json',
        ));
      },
    );

    test(
      'should return Date when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getNews();
        // assert
        expect(result, equals(newsEntity));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getNews;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}

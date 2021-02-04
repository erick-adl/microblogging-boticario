import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:microblogging/features/news/domain/entities/news_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final newModel = News(
      user: User(name: "teste", profilePicture: "teste"),
      message: Message(
        content: "test",
        createdAt: DateTime.now(),
      ));

  test(
    'should be a subclass of NewModel entity',
    () async {
      // assert
      expect(newModel, isA<News>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model ',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('news.json'));

        // act
        final result = NewsEntity.fromJson(jsonMap);
        // assert
        expect(result, isA<List<NewsEntity>>());
      },
    );
  });
}

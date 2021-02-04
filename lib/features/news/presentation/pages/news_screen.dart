import 'package:flutter/material.dart';
import 'package:microblogging/core/common/widgets/color_loader.dart';
import 'package:microblogging/core/common/custom_drawer/custom_drawer.dart';
import 'package:microblogging/features/news/presentation/pages/components/new_list_tile.dart';
import 'package:microblogging/features/news/presentation/provider/news_manager.dart';

import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('News'),
        centerTitle: true,
      ),
      body: Consumer<NewsManager>(
        builder: (_, newsManager, __) {
          if (newsManager.loading) {
            return Center(child: ColorLoader());
          }
          return ListView.builder(
              itemCount: newsManager.newsList.length,
              itemBuilder: (_, index) {
                return NewListTile(newsManager.newsList[index]);
              });
        },
      ),
    );
  }
}

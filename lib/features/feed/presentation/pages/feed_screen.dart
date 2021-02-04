import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:microblogging/core/common/custom_drawer/custom_drawer.dart';
import 'package:microblogging/features/feed/presentation/pages/components/custom_dialogin.dart';
import 'package:microblogging/features/feed/presentation/pages/components/feed_list_tile.dart';
import 'package:microblogging/features/feed/presentation/pages/components/new_post_widget.dart';
import 'package:microblogging/features/feed/presentation/provider/feed_manager.dart';

import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Feed'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: () => customDialog(context, NewPostWidget()),
        child: FaIcon(FontAwesomeIcons.penAlt),
      ),
      body: Consumer<FeedManager>(
        builder: (_, feedManager, __) {
          if (feedManager.feedList.isEmpty)
            return Center(
              child: Text(
                "We don't have publications yet",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            );

          return ListView.builder(
              itemCount: feedManager.feedList.length,
              itemBuilder: (_, index) {
                return FeedListTile(feedManager.feedList[index]);
              });
        },
      ),
    );
  }
}

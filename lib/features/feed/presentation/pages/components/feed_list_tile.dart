import 'package:flutter/material.dart';
import 'package:microblogging/features/feed/domain/entities/post_entity.dart';
import 'package:microblogging/features/feed/presentation/pages/components/custom_dialogin.dart';
import 'package:microblogging/features/feed/presentation/pages/components/new_post_widget.dart';
import 'package:microblogging/features/register/provider/user_manager.dart';
import 'package:provider/provider.dart';

class FeedListTile extends StatelessWidget {
  const FeedListTile(this.postEntity);

  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManager>(builder: (context, userManager, snapshot) {
      return GestureDetector(
        onLongPress: () {
          if (postEntity.name.contains(userManager.user.name)) {
            showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () => customDialog(
                                context,
                                NewPostWidget(
                                  postEntity: postEntity,
                                )),
                            child: Text(
                              'Edit',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              postEntity.delete();
                              Navigator.of(context).pop();
                            },
                            textColor: Colors.red,
                            child: const Text('Delete',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: PostContent(
            postEntity: postEntity,
          ),
        ),
      );
    });
  }
}

class PostContent extends StatelessWidget {
  final PostEntity postEntity;

  const PostContent({
    @required this.postEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${postEntity.name}',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontFamily: "Inter",
              ),
            ),
            Text(
              '${postEntity.createdAtString}',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontFamily: "Inter",
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          '${postEntity.text.capitalize()}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: "Inter",
          ),
        ),
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

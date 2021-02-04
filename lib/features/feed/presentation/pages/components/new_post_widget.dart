import 'package:flutter/material.dart';
import 'package:microblogging/features/feed/domain/entities/post_entity.dart';
import 'package:microblogging/features/feed/presentation/provider/feed_manager.dart';
import 'package:microblogging/features/register/provider/user_manager.dart';
import 'package:provider/provider.dart';

class NewPostWidget extends StatelessWidget {
  final PostEntity postEntity;

  final TextEditingController postController = TextEditingController();

  NewPostWidget({Key key, this.postEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 300,
        child: SizedBox.expand(
            child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Material(
            color: Colors.white,
            child: Consumer2<FeedManager, UserManager>(
                builder: (context, feedManager, userManager, __) {
              return Form(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        FlatButton(
                          onPressed: () {
                            if (postEntity == null) {
                              feedManager.post(
                                  user: userManager.user.name,
                                  text: postController.text);
                            } else {
                              postEntity.update(text: postController.text);
                            }

                            postController.clear();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Post',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'new post here...',
                          contentPadding: EdgeInsets.all(16),
                          fillColor: Colors.white10,
                          filled: true,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        maxLines: 8,
                        maxLength: 280,
                        controller: postController
                          ..text = postEntity?.text ?? "",
                        onChanged: (text) => {},
                        textInputAction: TextInputAction.done),
                  ],
                ),
              );
            }),
          ),
        )),
        margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}

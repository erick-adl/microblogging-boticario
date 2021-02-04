import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:microblogging/features/news/presentation/pages/news_screen.dart';

import 'package:microblogging/features/feed/presentation/pages/feed_screen.dart';
import 'package:microblogging/features/register/provider/page_manager.dart';
import 'package:microblogging/features/register/provider/user_manager.dart';

import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => PageManager(pageController),
        child: Consumer2<UserManager, PageManager>(
          builder: (_, userManager, pageManager, __) {
            return Scaffold(
              body: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  FeedScreen(),
                  NewsScreen(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: pageManager.page,
                onTap: (index) {
                  pageManager.setPage(index);
                  setState(() {});
                },
                items: [
                  BottomNavigationBarItem(
                      icon: new Icon(Icons.home), title: new Text('Feed')),
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.list),
                    title: new Text('News'),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

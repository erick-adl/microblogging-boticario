import 'package:flutter/material.dart';
import 'package:microblogging/core/common/splash/splash_screen.dart';
import 'package:microblogging/features/feed/presentation/provider/feed_manager.dart';
import 'package:microblogging/features/news/presentation/provider/news_manager.dart';
import 'package:microblogging/base_screen.dart';
import 'package:microblogging/features/register/provider/user_manager.dart';
import 'package:microblogging/features/register/screens/register_screen.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => FeedManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => NewsManager(getNews: di.sl()),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => RegisterScreen());
            case '/base':
              return MaterialPageRoute(
                  builder: (_) => BaseScreen(), settings: settings);

            case '/':
            default:
              return MaterialPageRoute(builder: (_) => SplashScreen());
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:microblogging/features/register/provider/user_manager.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  final String title;
  const SplashScreen({Key key, this.title = "Splash"}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      if (context.read<UserManager>().isLoggedIn) {
        Navigator.of(context).pushNamed('/base');
      } else {
        Navigator.of(context).pushNamed('/login');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                width: 140,
                height: 140,
                fit: BoxFit.contain,
                image: AssetImage('assets/images/Grupo-Boticario-Logo.png'),
              ),
              Text(
                "Microblogging",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

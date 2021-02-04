import 'package:flutter/material.dart';
import 'package:microblogging/features/register/provider/user_manager.dart';

import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: const [
              Color.fromARGB(255, 211, 118, 130),
              Color.fromARGB(255, 253, 181, 168)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          Consumer<UserManager>(
            builder: (_, userManager, __) {
              return Container(
                padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Center(
                      child: Image(
                        height: 120,
                        fit: BoxFit.fill,
                        image: AssetImage(
                            'assets/images/Grupo-Boticario-Logo.png'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Microblogging",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Olá, ${userManager.user?.name ?? ''}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

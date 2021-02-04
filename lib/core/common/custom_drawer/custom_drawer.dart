import 'package:flutter/material.dart';
import 'package:microblogging/core/common/custom_drawer/custom_drawer_header.dart';
import 'package:microblogging/features/register/provider/user_manager.dart';

import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 203, 236, 241),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          ListView(
            children: <Widget>[
              CustomDrawerHeader(),
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  return GestureDetector(
                    onTap: () {
                      userManager.signOut();
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(
                              Icons.exit_to_app,
                              size: 32,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Sair',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[700]),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

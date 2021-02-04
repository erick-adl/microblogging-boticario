import 'package:flutter/material.dart';
import 'package:microblogging/features/register/screens/components/device_config.dart';

class DefaultTitle extends StatelessWidget {
  const DefaultTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceData deviceData = DeviceData.init(context);
    return Padding(
      padding: EdgeInsets.only(
        top: deviceData.screenHeight * 0.07,
        bottom: deviceData.screenHeight * 0.05,
        left: deviceData.screenWidth * 0.08,
        right: deviceData.screenWidth * 0.08,
      ),
      child: Column(
        children: <Widget>[
          Center(
            child: Image(
              width: 140,
              height: 100,
              fit: BoxFit.contain,
              image: AssetImage('assets/images/Grupo-Boticario-Logo.png'),
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
        ],
      ),
    );
  }
}

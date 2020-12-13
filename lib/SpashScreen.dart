import 'package:flutter/material.dart';
import 'package:hivedatabase/mainscreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Spacer(
            flex: 1,
          ),
          Image.asset('assets/icons/pngegg.png'),
          Spacer(
            flex: 1,
          ),
          Text(
            'Welcome to Calendo',
            style: TextStyle(fontSize: 30),
          ),
          Spacer(
            flex: 1,
          ),
          Text(
            "Let's Schedule your life",
            style: TextStyle(fontSize: 20),
          ),
          Spacer(
            flex: 3,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MainScreen()));
            },
            child: Container(
              height: 60,
              width: size.width - 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFF2F4858)),
              child: Center(
                  child: Text(
                'Get Started',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
            ),
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}

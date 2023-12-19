import 'package:flutter/material.dart';
import 'package:flutter_9nov24/main.dart';
import 'package:flutter_9nov24/screens/home_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? Key}) : super(key: Key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetoHome();
  }

  _navigatetoHome() async {
    await Future.delayed(const Duration(milliseconds: 4500), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  /* ----------- bg color  ---------------*/

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 66, 126),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('assets/logoCC.png')),
          ],
        ),
      ),
    );
  }
}

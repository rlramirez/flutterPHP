import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Chichas Conducen",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(image: AssetImage('assets/logoCCpink.png')),
              const SizedBox(
                height: 60,
              ),
              Text(
                'Login',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Text(
                'Ingresa con tus datos de acceso a la app',
                style: TextStyle(color: Color.fromARGB(150, 73, 72, 72)),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

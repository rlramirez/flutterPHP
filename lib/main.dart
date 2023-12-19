import 'package:flutter/material.dart';
import 'package:flutter_9nov24/screens/splash.dart';
import 'package:flutter_9nov24/users/authentication/login_screen.dart';
import 'package:flutter_9nov24/users/fragments/dashboard_of_fragments.dart';
import 'package:flutter_9nov24/users/userPreferences/userPreferences.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo :',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 250, 3, 176)),
          useMaterial3: true,
        ),
        home: FutureBuilder(
          future: RememberUserPrefs.readUserInfo(),
          builder: (context, dataSnapShot) {
            if (dataSnapShot.data == null) {
              return LoginScreen();
            } else {
              return DashboardOfFragments();
            }
          },
        )
        //home: const Splash(),
        );
  }
}

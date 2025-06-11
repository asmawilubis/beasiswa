import 'package:beasiswa/pages/edit_profile_page.dart';
import 'package:beasiswa/pages/splash_page.dart';
import 'package:beasiswa/pages/login_page.dart';
import 'package:beasiswa/pages/register_page.dart';
import 'package:beasiswa/pages/home/main_page_.dart';
import 'package:beasiswa/providers/auth_provider.dart';
import 'package:beasiswa/providers/beasiswa_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => BeasiswaProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/home': (context) => MainPage(),
          '/edit-profile': (context) => EditProfilePage(),
        },
      ),
    );
  }
}

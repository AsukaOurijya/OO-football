import 'package:flutter/material.dart';
import 'package:oofootball/screens/menu.dart';
import 'package:oofootball/screens/register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:oofootball/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<CookieRequest>(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'OO Football',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(secondary: Colors.blueAccent[400]),
        ),
        home: const LoginPage(),
        routes: {
          '/home': (_) => const MyHomePage(),
          '/register': (_) => const RegisterPage(),
        },
      ),
    );
  }
}

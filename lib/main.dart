import 'package:coop/constant.dart';
import 'package:coop/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COOPE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: MaterialColor(0xff00aeef),
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Color(0xfff1f1f1),
        textTheme: kLightTextTheme,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: kPrimaryColor.withOpacity(0.4)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: kPrimaryColor.withOpacity(0.4)),
          ),
        ),
      ),
      home: const Login(),
    );
  }
}

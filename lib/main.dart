import 'package:flutter/material.dart';
import 'my_main_page.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "8Bit Clicker",
      theme: ThemeData(),
      home: MyMainPage(),
    );
  }
}

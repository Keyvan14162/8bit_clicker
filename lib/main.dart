import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'my_main_page.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top]).then(
    (_) => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "8Bit Clicker",
      theme: ThemeData(),
      home: MyMainPage(),
    );
  }
}

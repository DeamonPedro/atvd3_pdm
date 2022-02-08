import 'package:atvd3_pdm/pages/Home/home_page.dart';
import 'package:atvd3_pdm/pages/Login/login_page.dart';
import 'package:atvd3_pdm/pages/Note/note_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'atvd3_pdm',
      theme: ThemeData(
          primaryColor: Colors.white,
          progressIndicatorTheme:
              const ProgressIndicatorThemeData(color: Colors.grey),
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.grey)),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/note': (context) => const NotePage(),
      },
    );
  }
}

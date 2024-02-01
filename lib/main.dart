import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roleapp/presentation/pages/home_page.dart';
import 'package:roleapp/presentation/pages/login_page.dart';
import 'package:roleapp/presentation/provider/auth_notifier.dart';
import 'package:roleapp/injection.dart' as di;
import 'package:roleapp/presentation/provider/home_notifier.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<AuthNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<HomeNotifier>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}

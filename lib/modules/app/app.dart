import 'package:flutter/material.dart';
import 'package:ngeuvid/main.dart';
import 'package:ngeuvid/router.dart';
import 'package:ngeuvid/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: getIt<AppRouter>().config(),
      title: 'Flutter Demo',
      theme: ngeuvidDarkTheme,
    );
  }
}

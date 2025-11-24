import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localstorage/localstorage.dart';
import 'package:ngeuvid/modules/app/app.dart';
import 'package:ngeuvid/router.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerSingleton<LocalStorage>(LocalStorage("APP_DATA"));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();

  runApp(const App());
}

import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_teme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      title: 'Material App',
    );
  }
}

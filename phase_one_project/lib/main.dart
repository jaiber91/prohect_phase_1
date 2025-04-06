import 'package:flutter/material.dart';

import 'presentation/routes/app_routes.dart';
import 'presentation/routes/path_routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPathsRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}

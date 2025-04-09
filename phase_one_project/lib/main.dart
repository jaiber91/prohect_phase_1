import 'package:flutter/material.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/widgets/bottom_nav_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      home: BottomNavWidget(),
    );
  }
}

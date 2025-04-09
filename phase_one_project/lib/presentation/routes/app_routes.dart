import 'package:flutter/material.dart';

import '../screens/detail_screen.dart';
import '../screens/form_screen.dart';
import 'path_routes.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppPathsRoutes.details) {
      final id = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => DetailScreen(idCardSelect: id),
      );
    }

    if (settings.name == AppPathsRoutes.form) {
      return MaterialPageRoute(builder: (context) => const FormScreen());
    }

    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(child: Text('Ruta no encontrada')),
      ),
    );
  }
}

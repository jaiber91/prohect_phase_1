import 'package:flutter/material.dart';

import '../screens/detail_screen.dart';
import '../screens/form_screen.dart';
import 'path_routes.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> _routes = {
    AppPathsRoutes.details: (_) => const DetailScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppPathsRoutes.form) {
      final isEdit = settings.arguments as bool? ?? false;
      return MaterialPageRoute(
        builder: (_) => FormScreen(isEdit: isEdit),
      );
    }

    final builder = _routes[settings.name];

    if (builder != null) {
      return MaterialPageRoute(builder: builder);
    }

    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Ruta no encontrada')),
      ),
    );
  }
}

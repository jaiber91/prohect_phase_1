import 'package:flutter/material.dart';

import '../screens/detail_screen.dart';
import '../screens/form_screen.dart';
import '../screens/home_screen.dart';
import 'path_routes.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    AppPathsRoutes.home: (context) => HomeScreen(),
    AppPathsRoutes.details: (context) => DetailScreen(),
    AppPathsRoutes.form: (context) => FormScreen(),
  };
}

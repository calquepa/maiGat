import 'package:flutter/material.dart';

import 'package:mai_gat/feature/cat_breed/presentation/pages/cat_breed_page.dart';
import 'package:mai_gat/feature/cat_breed/presentation/widgets/cat_breed_summary.dart';

class Routes {

  // App
  static const homeRoute = 'CatBreedPage';

  // Summary Cat Breed
  static const summaryBreedRoute = 'CatBreedSummary';

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {

    Map<String, Widget Function(BuildContext)> routes = {};

    routes.addAll({
      // Home
      homeRoute : ( BuildContext context ) => const CatBreedPage(),
      // Settings
      summaryBreedRoute : ( BuildContext context ) => const CatBreedSummary(),
    });

    return routes;
  }

  static Route<dynamic> onGenerateRoute( RouteSettings settings) {        
    return MaterialPageRoute(
        builder: (context) => const CatBreedPage(),
    );
  }

}
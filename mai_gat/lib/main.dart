import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mai_gat/core/config/environment_config.dart';
import 'package:mai_gat/core/navigation/routes.dart';
import 'package:mai_gat/feature/cat_breed/BLOC/cat_breed_bloc.dart';
import 'package:mai_gat/feature/cat_breed/presentation/pages/cat_breed_page.dart';

void main() {
  runApp(BlocProvider(create: (context) => CatBreedBloc(), 
    child:  const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)), child: child!);
      },
      debugShowCheckedModeBanner: false,
      title: EnvironmentConfig.appTitle,
      home: const CatBreedPage(),
      routes: Routes.getAppRoutes(),
    );
  }
}

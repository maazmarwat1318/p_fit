import 'package:flutter/material.dart';
import 'package:p_fit/features/catalog/screens/exercise_catalog_screen.dart';
import 'package:p_fit/features/catalog/screens/workout_catalog_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});
  static const route = '/catalog-screen';
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catalog')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Workouts'),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () {
              Navigator.of(context).pushNamed(WorkoutCatalogScreen.route);
            },
          ),
          ListTile(
            title: const Text('Exercises'),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () {
              Navigator.of(context).pushNamed(ExerciseCatalogScreen.route);
            },
          )
        ],
      ),
    );
  }
}

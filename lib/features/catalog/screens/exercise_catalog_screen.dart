import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseCatalogScreen extends ConsumerWidget {
  const ExerciseCatalogScreen({super.key});
  static const route = '/exercise-catalog-screen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Catalog'),
      ),
    );
  }
}

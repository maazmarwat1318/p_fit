import 'package:flutter/material.dart';

class SuperFoodsScreen extends StatefulWidget {
  const SuperFoodsScreen({super.key});
  static const route = '/super-foods-screen';
  @override
  State<SuperFoodsScreen> createState() => _SuperFoodsScreenState();
}

class _SuperFoodsScreenState extends State<SuperFoodsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Super Foods')),
    );
  }
}

import 'package:flutter/material.dart';

class InfoCardsScreen extends StatefulWidget {
  const InfoCardsScreen({super.key});
  static const route = '/info-cards-screen';
  @override
  State<InfoCardsScreen> createState() => _InfoCardsScreenState();
}

class _InfoCardsScreenState extends State<InfoCardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info Cards')),
    );
  }
}

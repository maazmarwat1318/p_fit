import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p_fit/core/constants/spacing.dart';
import 'package:p_fit/features/home/widgets/app_drawer.dart';
import 'package:p_fit/features/home/widgets/home_info_tiles.dart';
import 'package:p_fit/features/activity/widgets/progress_indicators.dart';
import 'package:p_fit/features/workout/screens/workout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const route = '/home-screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GlobalKey<ScaffoldState> _scaffoldStateKey;

  @override
  void initState() {
    _scaffoldStateKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldStateKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('P Fit'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
                onPressed: () {
                  _scaffoldStateKey.currentState!.openDrawer();
                },
                icon: const FaIcon(FontAwesomeIcons.bars)),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(
            top: Spacing.scaffoldPadding - 10,
            left: Spacing.scaffoldPadding,
            right: Spacing.scaffoldPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ProgressIndicators(),
              const SizedBox(
                height: Spacing.normalWidgetSpacing,
              ),
              Consumer(builder: (context, ref, _) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(WorkoutScreen.route);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12.0),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Start Workout',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }),
              const SizedBox(
                height: Spacing.normalWidgetSpacing,
              ),
              const HomeInfoTiles(),
            ],
          ),
        ),
      ),
    );
  }
}

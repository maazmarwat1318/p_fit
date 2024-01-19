import 'package:flutter/material.dart';
import 'package:p_fit/core/enums.dart';
import 'package:p_fit/features/activity/screens/activity_screen.dart';
import 'package:p_fit/features/authentication/screens/email_signin_screen.dart';
import 'package:p_fit/features/authentication/screens/forgot_password_screen.dart';
import 'package:p_fit/features/authentication/screens/on_boarding_screen.dart';
import 'package:p_fit/features/catalog/screens/catalog_screen.dart';
import 'package:p_fit/features/catalog/screens/exercise_catalog_screen.dart';
import 'package:p_fit/features/catalog/screens/workout_catalog_screen.dart';
import 'package:p_fit/features/catalog/screens/temp_workout_overview_screen.dart';
import 'package:p_fit/features/home/screens/homescreen.dart';
import 'package:p_fit/features/info_cards/screens/info_cards_screen.dart';
import 'package:p_fit/features/super_foods/screens/super_foods_screen.dart';
import 'package:p_fit/features/workout/screens/workout_exercises_screen.dart';
import 'package:p_fit/features/workout/screens/workout_screen.dart';

class Routes {
  static const homeScreen = HomeScreen.route;
  static const onBoardingScreen = OnBoardingScreen.route;
  static const emailSignInScreen = EmailSignInScreen.route;
  static const forgotPasswordScreen = ForgotPasswordScreen.route;
  static const catalogScreen = CatalogScreen.route;
  static const superFoodsScreen = SuperFoodsScreen.route;
  static const infoCardsScreen = InfoCardsScreen.route;
  static const activityScreen = ActivityScreen.route;
  static const workoutScreen = WorkoutScreen.route;
  static const workoutExercisesScreen = WorkoutExercisesScreen.route;
  static const workoutCatalogScreen = WorkoutCatalogScreen.route;
  static const exerciseCatalogScreen = ExerciseCatalogScreen.route;
  static const tempWorkoutOverviewScreen = TempWorkoutOverviewScreen.route;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );
      case emailSignInScreen:
        return MaterialPageRoute(
          builder: (context) => const EmailSignInScreen(),
        );
      case forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );
      case catalogScreen:
        return MaterialPageRoute(
          builder: (context) => const CatalogScreen(),
        );
      case activityScreen:
        return MaterialPageRoute(
          builder: (context) => const ActivityScreen(),
        );
      case infoCardsScreen:
        return MaterialPageRoute(
          builder: (context) => const InfoCardsScreen(),
        );
      case superFoodsScreen:
        return MaterialPageRoute(
          builder: (context) => const SuperFoodsScreen(),
        );
      case workoutScreen:
        return MaterialPageRoute(
          builder: (context) => const WorkoutScreen(),
        );
      case workoutExercisesScreen:
        final type = settings.arguments as WorkoutType;
        return MaterialPageRoute(
          builder: (context) => WorkoutExercisesScreen(
            type: type,
          ),
        );
      case workoutCatalogScreen:
        return MaterialPageRoute(
          builder: (context) => const WorkoutCatalogScreen(),
        );
      case exerciseCatalogScreen:
        return MaterialPageRoute(
          builder: (context) => const ExerciseCatalogScreen(),
        );
      case tempWorkoutOverviewScreen:
        return MaterialPageRoute(
          builder: (context) => const TempWorkoutOverviewScreen(),
        );
      //Make an error object for it
      default:
        throw 'Route Does not Exist';
    }
  }
}

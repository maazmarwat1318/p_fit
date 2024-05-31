import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_fit/app_initialization/app_initialization.dart';
import 'package:p_fit/core/common_widgets/max_width_container.dart';
import 'package:p_fit/features/authentication/controller/auth_controller.dart';
import 'package:p_fit/features/authentication/screens/on_boarding_screen.dart';
import 'package:p_fit/features/home/screens/homescreen.dart';
import 'package:p_fit/firebase_options.dart';
import 'package:p_fit/core/routes/routes.dart';
import 'package:p_fit/core/themes/dark_theme.dart';
import 'package:p_fit/core/themes/light_theme.dart';
import 'package:p_fit/core/themes/theme_manager.dart';

void main() async {
  WidgetsBinding widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  await Future.wait([
    AppInitialization.initializeApp(),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    )
  ]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeManagerProvider);
        return MaxWidthContainer(
          maxWidth: 550,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'P Fit',
            darkTheme: DarkTheme.data,
            themeMode: themeMode.mode,
            theme: LightTheme.data,
            onGenerateRoute: Routes.generateRoute,
            home: ref.watch(authControllerProvider) != null
                ? const HomeScreen()
                : const OnBoardingScreen(),
          ),
        );
      },
    );
  }
}

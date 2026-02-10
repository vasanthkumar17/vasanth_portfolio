import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/strings.dart';
import 'providers/theme_provider.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: theme.themeMode,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: true,
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      home: Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) {
            // Allow normal scrolling but block any scale events
            if (event.scrollDelta.dy.abs() < 1 && event.scrollDelta.dx.abs() < 1) {
              // This might be a zoom gesture, ignore it
              return;
            }
          }
        },
        child: const HomeScreen(),
      ),
    );
  }
}

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
      home: InteractiveViewer(
        constrained: true,
        panEnabled: true,
        scaleEnabled: true,
        minScale: 1.0,
        maxScale: 3.0,
        child: const HomeScreen(),
      ),
    );
  }
}

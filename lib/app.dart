import 'package:flutter/material.dart';
import 'package:smart_hydroponic/routes/app_routes.dart';
import 'package:smart_hydroponic/screens/login/login_screen.dart';
import 'package:smart_hydroponic/screens/notification/notification_screen.dart';
import 'package:smart_hydroponic/screens/profile/profile_screen.dart';
import 'package:smart_hydroponic/screens/schedule/schedule_screen.dart';
import 'package:smart_hydroponic/screens/welcome/welcome_screen.dart';
import 'package:smart_hydroponic/shell/main_shell.dart';
import 'package:smart_hydroponic/theme/app_theme.dart';

class SmartHydroponicApp extends StatelessWidget {
  const SmartHydroponicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Hydroponic',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.welcome,
      routes: {
        AppRoutes.welcome: (_) => const WelcomeScreen(),
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.main: (_) => const MainShell(),
        AppRoutes.schedule: (_) => const ScheduleScreen(),
        AppRoutes.notification: (_) => const NotificationScreen(),
        AppRoutes.profile: (_) => const ProfileScreen(),
      },
    );
  }
}

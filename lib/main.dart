import 'package:flutter/material.dart';
import 'package:smart_hydroponic/app.dart';
import 'package:smart_hydroponic/auth/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.instance.initialize();
  runApp(const SmartHydroponicApp());
}

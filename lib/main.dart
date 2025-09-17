import 'package:doalink/screens/auth/login_screen.dart';
import 'package:doalink/screens/auth/register_with_email.dart';
import 'package:doalink/screens/auth/auth_home_screen.dart';
import 'package:doalink/screens/app/home_screen.dart';
import 'package:doalink/theme/app_colors.dart';
import 'package:doalink/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DoaLink',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.orange_500),
        useMaterial3: true,
      ),
      home: SplashScreen(child: HomePage()),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterWithEmail(),
        '/home': (context) => const MapScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

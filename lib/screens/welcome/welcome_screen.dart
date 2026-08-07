import 'package:flutter/material.dart';
import 'package:smart_hydroponic/routes/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const Color _loginGreen = Color(0xFF16A34A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/welcome.png',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/logo-hydro.png',
                      width: 224,
                      height: 208,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 100),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        key: const Key('welcome_login_button'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _loginGreen,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.login);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

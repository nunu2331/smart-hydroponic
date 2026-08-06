import 'package:flutter/material.dart';
import 'package:smart_hydroponic/routes/app_routes.dart';
import 'package:smart_hydroponic/theme/app_colors.dart';
import 'package:smart_hydroponic/widgets/common_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Positioned(
            top: -80,
            left: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: AppColors.mint.withValues(alpha: 0.55),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.28,
            left: 24,
            child: Column(
              children: List.generate(
                4,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: List.generate(
                      3,
                      (j) => Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: AppColors.border.withValues(alpha: 0.7),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
                const LeafLogo(size: 72),
                const SizedBox(height: 16),
                const Text(
                  'Smart',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.1,
                  ),
                ),
                const Text(
                  'Hydroponic',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'IoT Hydroponic System',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.textPrimary,
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
                ),
                const Spacer(),
                SizedBox(
                  height: size.height * 0.28,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/welcome_plants.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.mint,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.grass,
                            size: 64,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.white,
                              Color(0x00FFFFFF),
                            ],
                            stops: [0.0, 0.35],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:doalink/screens/auth/login_screen.dart';
import 'package:doalink/screens/auth/register_with_email.dart';
import 'package:doalink/theme/app_colors.dart';
import 'package:doalink/widgets/auth/onboarding_carousel.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class HomePageAuth extends StatelessWidget {
  const HomePageAuth({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: const Text(
                    "Bem-vindo ao DoaLink",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  duration: const Duration(milliseconds: 1200),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Conectando quem quer doar com quem precisa de forma simples e segura",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                        height: 1.5,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            OnboardingCarousel(
              slides: DoaLinkSlides.slides,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              showIndicators: true,
            ),
            Column(
              children: <Widget>[
                FadeInUp(
                  duration: const Duration(milliseconds: 1500),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue_600,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shadowColor: AppColors.blue_600.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Entrar",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  duration: const Duration(milliseconds: 1600),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterWithEmail(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.orange_500,
                        side: const BorderSide(
                          color: AppColors.orange_500,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Cadastrar-se",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

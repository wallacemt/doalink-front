import 'package:doalink/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:animate_do/animate_do.dart';

class AuthOptionsSelect extends StatelessWidget {
  const AuthOptionsSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        duration: const Duration(milliseconds: 1000),
        child: SizedBox(
            width: 300,
            child: Column(
              children: [
                FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: Text(
                      "Entrar com uma das opções abaixo ou com email",
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    )),
                const AuthOptionsSelectCard(
                  title: 'Entrar com Google',
                  iconForSrc: "assets/images/icon-google.png",
                  routeName: '/login/google',
                ),
                const AuthOptionsSelectCard(
                  title: 'Entrar com IOS',
                  iconForSrc: "assets/images/icon-ios.png",
                  routeName: '/login/ios',
                ),
                const AuthOptionsSelectCard(
                  title: 'Entrar com Email',
                  icon: Icons.email,
                  routeName: '/login',
                ),
              ],
            )));
  }
}

class AuthOptionsSelectCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? iconForSrc;
  final String routeName;
  const AuthOptionsSelectCard({
    super.key,
    required this.title,
    this.icon,
    this.iconForSrc = '',
    this.routeName = '',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cleanCian,
      child: OutlinedButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(routeName, arguments: {"method": "email"});
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(spacing: 2.3, children: [
            icon != null
                ? Icon(
                    icon,
                    size: 32.0,
                    color: AppColors.blue_600,
                  )
                : const SizedBox.shrink(),
            iconForSrc != null && iconForSrc!.isNotEmpty
                ? Image.asset("$iconForSrc", width: 32.0, height: 32.0)
                : const SizedBox.shrink(),
            const SizedBox(width: 16.0),
            Text(
              title,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18.0, color: AppColors.blue_600, height: 1.2),
            ),
          ]),
        ),
      ),
    );
  }
}

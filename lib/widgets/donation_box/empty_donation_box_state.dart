import 'package:animate_do/animate_do.dart';
import 'package:doalink/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EmptyDonationBoxState extends StatelessWidget {
  final VoidCallback onAddFirstItem;

  const EmptyDonationBoxState({
    super.key,
    required this.onAddFirstItem,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 800),
      child: Center(
       
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ilustração da caixa vazia
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.orange_500.withOpacity(0.1),
                      AppColors.orange_500.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.inventory_2_outlined,
                  size: 80,
                  color: AppColors.orange_500.withOpacity(0.7),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Título
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 200),
              child: const Text(
                'Sua caixa de doações está vazia',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 8),

            // Subtítulo
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 300),
              child: const Text(
                'Comece adicionando os itens que você\ndeseja doar para quem precisa',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.medianCian,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 32),

            // Botão de ação
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 400),
              child: ElevatedButton.icon(
                onPressed: onAddFirstItem,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange_500,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.add_circle_outline, size: 20),
                label: const Text(
                  'Adicionar primeiro item',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

import 'package:doalink/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

// Model para representar informações da caixa de doação
class DonationBoxInfo {
  final int itemCount;
  final String lastItemAdded;
  final DateTime? lastUpdate;

  const DonationBoxInfo({
    required this.itemCount,
    required this.lastItemAdded,
    this.lastUpdate,
  });
}

class DonationBoxSection extends StatelessWidget {
  final DonationBoxInfo? donationBoxInfo;
  final VoidCallback onSeeMore;
  final VoidCallback onAddItem;

  const DonationBoxSection({
    super.key,
    this.donationBoxInfo,
    required this.onSeeMore,
    required this.onAddItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          FadeInLeft(
            duration: const Duration(milliseconds: 700),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.blue_500.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.inventory_2_rounded,
                    color: AppColors.blue_500,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Minha Caixa de Doação',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Donation Box Card
          FadeInUp(
            duration: const Duration(milliseconds: 900),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.orange_500.withOpacity(0.05),
                    AppColors.blue_500.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.orange_500.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Icon Circle
                  Container(
                    width: 64,
                    height: 64,
                    decoration:  BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.orange_500,
                          AppColors.orange_600,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.orange_500.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.inventory_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Box Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (donationBoxInfo != null &&
                            donationBoxInfo!.itemCount > 0) ...[
                          Text(
                            'Você tem ${donationBoxInfo!.itemCount} ${donationBoxInfo!.itemCount == 1 ? 'item' : 'itens'}.',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          if (donationBoxInfo!.lastItemAdded.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Último: ${donationBoxInfo!.lastItemAdded}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.medianCian,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ] else ...[
                          const Text(
                            'Sua caixa está vazia.',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                         const  Text(
                            'Adicione itens para doação',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.medianCian,
                            ),
                          ),
                        ],

                        const SizedBox(height: 16),

                        // Action Buttons
                        Row(
                          children: [
                            // See More Button
                            if (donationBoxInfo != null &&
                                donationBoxInfo!.itemCount > 0) ...[
                              Expanded(
                                flex: 2,
                                child: OutlinedButton(
                                  onPressed: onSeeMore,
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: AppColors.orange_500,
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                  ),
                                  child: const Text(
                                    'Ver mais',
                                    style: TextStyle(
                                      color: AppColors.orange_500,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],

                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:doalink/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

// Model para representar uma ONG
class NearbyNgo {
  final String id;
  final String name;
  final String description;
  final double distance;
  final String imageUrl;

  const NearbyNgo({
    required this.id,
    required this.name,
    required this.description,
    required this.distance,
    required this.imageUrl,
  });
}

class NearbyNgosSection extends StatelessWidget {
  final List<NearbyNgo> ngos;
  final VoidCallback? onSeeAll;

  const NearbyNgosSection({
    super.key,
    required this.ngos,
    this.onSeeAll,
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
            duration: const Duration(milliseconds: 600),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.green_500.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: AppColors.green_500,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'ONGs Próximas',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                if (onSeeAll != null)
                  TextButton(
                    onPressed: onSeeAll,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                    ),
                    child: const Text(
                      'Ver todas',
                      style: TextStyle(
                        color: AppColors.orange_500,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // NGOs List
          if (ngos.isEmpty) _buildEmptyState() else _buildNgosList(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cleanCian,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.medianCian.withOpacity(0.1),
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.search_rounded,
              size: 48,
              color: AppColors.medianCian.withOpacity(0.5),
            ),
            const SizedBox(height: 12),
            const Text(
              'Nenhuma ONG encontrada',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.medianCian,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Permita acesso à localização para encontrar ONGs próximas',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.medianCian.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNgosList() {
    return Column(
      children: [
        ...ngos.take(3).map((ngo) => FadeInUp(
              duration: Duration(milliseconds: 600 + (ngos.indexOf(ngo) * 100)),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: NgoCard(ngo: ngo),
              ),
            )),
      ],
    );
  }
}

class NgoCard extends StatelessWidget {
  final NearbyNgo ngo;

  const NgoCard({
    super.key,
    required this.ngo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: AppColors.cleanCian,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.cleanCian,
              image: ngo.imageUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(ngo.imageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: ngo.imageUrl.isEmpty
                ? const Icon(
                    Icons.volunteer_activism_rounded,
                    color: AppColors.orange_500,
                    size: 28,
                  )
                : null,
          ),

          const SizedBox(width: 16),

          // NGO Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NGO Name
                Text(
                  ngo.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // Distance
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 16,
                      color: AppColors.green_500,
                    ),
                    const SizedBox(width: 4),
                     Text(
                      '${ngo.distance.toStringAsFixed(1)}km',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green_500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Description
                Text(
                  ngo.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.medianCian,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Arrow
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.orange_500.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.orange_500,
            ),
          ),
        ],
      ),
    );
  }
}

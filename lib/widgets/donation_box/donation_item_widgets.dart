import 'package:animate_do/animate_do.dart';
import 'package:doalink/models/donation_category.dart';
import 'package:doalink/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryGridCard extends StatelessWidget {
  final DonationCategory category;
  final VoidCallback onTap;
  final int animationDelay;

  const CategoryGridCard({
    super.key,
    required this.category,
    required this.onTap,
    this.animationDelay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: Duration(milliseconds: animationDelay * 100),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  category.color.withOpacity(0.1),
                  category.color.withOpacity(0.05),
                ],
              ),
              border: Border.all(
                color: category.color.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: category.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    category.icon,
                    color: category.color,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCategoryCard extends StatelessWidget {
  final VoidCallback onTap;

  const CustomCategoryCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 800),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.orange_500.withOpacity(0.15),
                  AppColors.orange_500.withOpacity(0.08),
                ],
              ),
              border: Border.all(
                color: AppColors.orange_500.withOpacity(0.4),
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.orange_500.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.add_circle_outline,
                    color: AppColors.orange_500,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Personalizar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.orange_500,
                  ),
                ),
                const Text(
                  'Item próprio',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.medianCian,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DonationItemCard extends StatelessWidget {
  final DonationItem item;
  final bool isEditMode;
  final VoidCallback? onRemove;
  final ValueChanged<int>? onQuantityChanged;
  final int animationDelay;

  const DonationItemCard({
    super.key,
    required this.item,
    required this.isEditMode,
    this.onRemove,
    this.onQuantityChanged,
    this.animationDelay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 500),
      delay: Duration(milliseconds: animationDelay * 100),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: isEditMode
              ? IconButton(
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.red.shade400,
                    size: 24,
                  ),
                  onPressed: onRemove,
                )
              : Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    item.icon,
                    color: item.color,
                    size: 20,
                  ),
                ),
          title: Row(
            children: [
                Expanded(
                child: Text(
                  item.displayName,
                  style: const TextStyle(
                  fontSize: 14,
                  fontFamily: "TextsBody",
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                ),
                if (item.isCustom)
                const Icon(
                  Icons.edit,
                  color: AppColors.orange_500,
                  size: 16,
                ),
            ],
          ),
          trailing: isEditMode
              ? SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.cleanCian),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 18),
                              onPressed: item.quantity > 1
                                  ? () =>
                                      onQuantityChanged?.call(item.quantity - 1)
                                  : null,
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 18),
                              onPressed: () =>
                                  onQuantityChanged?.call(item.quantity + 1),
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${item.quantity}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: item.color,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:doalink/models/donation_category.dart';
import 'package:doalink/theme/app_colors.dart';
import 'package:doalink/utils/donation_category_service.dart';
import 'package:doalink/widgets/donation_box/donation_item_widgets.dart';
import 'package:flutter/material.dart';

class CategorySelectionModal extends StatefulWidget {
  const CategorySelectionModal({super.key});

  @override
  State<CategorySelectionModal> createState() => _CategorySelectionModalState();
}

class _CategorySelectionModalState extends State<CategorySelectionModal> {
  String? selectedMainCategory;
  bool showSubCategories = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.85,
      minChildSize: 0.4,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              _buildModalHeader(),
              Expanded(
                child: showSubCategories
                    ? _buildSubCategoriesView(scrollController)
                    : _buildMainCategoriesView(scrollController),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModalHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          // Handle bar
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.medianCian.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (showSubCategories) ...[
                IconButton(
                  onPressed: () {
                    setState(() {
                      showSubCategories = false;
                      selectedMainCategory = null;
                    });
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  showSubCategories
                      ? 'Escolha uma subcategoria'
                      : 'Adicionar item à doação',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
          if (!showSubCategories) ...[
            const SizedBox(height: 4),
           const  Text(
              'Selecione uma categoria ou adicione um item personalizado',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.medianCian,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMainCategoriesView(ScrollController scrollController) {
    final categories = DonationCategoryService.getMainCategories();

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: GridView.builder(
              controller: scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                // childAspectRatio: 0.85,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryGridCard(
                  category: category,
                  animationDelay: index,
                  onTap: () => _handleCategoryTap(category),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Botão personalizar em destaque
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SizedBox(
            width: double.infinity,
            child: CustomCategoryCard(
              onTap: _showCustomItemDialog,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubCategoriesView(ScrollController scrollController) {
    if (selectedMainCategory == null) return const SizedBox.shrink();

    final subCategories =
        DonationCategoryService.getSubCategories(selectedMainCategory!);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        controller: scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemCount: subCategories.length,
        itemBuilder: (context, index) {
          final subCategory = subCategories[index];
          return CategoryGridCard(
            category: subCategory,
            animationDelay: index,
            onTap: () => _selectCategory(subCategory),
          );
        },
      ),
    );
  }

  void _handleCategoryTap(DonationCategory category) {
    if (DonationCategoryService.hasSubCategories(category.id)) {
      setState(() {
        selectedMainCategory = category.id;
        showSubCategories = true;
      });
    } else {
      _selectCategory(category);
    }
  }

  void _selectCategory(DonationCategory category) {
    final donationItem = DonationItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      categoryId: category.id,
      categoryName: category.name,
      icon: category.icon,
      color: category.color,
      quantity: 1,
    );

    Navigator.of(context).pop(donationItem);
  }

  void _showCustomItemDialog() {
    showDialog(
      context: context,
      builder: (context) => const CustomItemDialog(),
    ).then((customItem) {
      if (customItem != null && mounted) {
        Navigator.of(context).pop(customItem);
      }
    });
  }
}

class CustomItemDialog extends StatefulWidget {
  const CustomItemDialog({super.key});

  @override
  State<CustomItemDialog> createState() => _CustomItemDialogState();
}

class _CustomItemDialogState extends State<CustomItemDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 300),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.orange_500.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.add_circle_outline,
                color: AppColors.orange_500,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Item Personalizado',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Descreva o item que você quer doar:',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.medianCian,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Ex: Cobertor de lã, Panela de pressão...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.cleanCian),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: AppColors.orange_500, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, descreva o item';
                  }
                  if (value.trim().length < 3) {
                    return 'Descrição muito curta (mín. 3 caracteres)';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
                maxLength: 50,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: AppColors.medianCian),
            ),
          ),
          ElevatedButton(
            onPressed: _submitCustomItem,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orange_500,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  void _submitCustomItem() {
    if (_formKey.currentState!.validate()) {
      final customItem = DonationItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        categoryId: 'custom',
        categoryName: 'Personalizado',
        icon: Icons.category,
        color: AppColors.orange_500,
        quantity: 1,
        customName: _controller.text.trim(),
      );

      Navigator.of(context).pop(customItem);
    }
  }
}

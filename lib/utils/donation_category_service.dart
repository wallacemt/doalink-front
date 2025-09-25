import 'package:flutter/material.dart';
import 'package:doalink/models/donation_category.dart';
import 'package:doalink/theme/app_colors.dart';

class DonationCategoryService {
  // Dados mock das categorias de doação
  static final List<DonationCategory> _categories =  [
    const DonationCategory(
      id: 'roupas',
      name: 'Roupas',
      icon: Icons.checkroom,
      color: AppColors.blue_500,
    ),
    const DonationCategory(
      id: 'calcados',
      name: 'Calçados',
      icon: Icons.shopping_bag_outlined,
      color: AppColors.green_500,
    ),
    const DonationCategory(
      id: 'acessorios',
      name: 'Acessórios',
      icon: Icons.watch,
      color: AppColors.orange_500,
    ),
   const  DonationCategory(
      id: 'brinquedos',
      name: 'Brinquedos',
      icon: Icons.toys,
      color: Colors.pink,
    ),
    const DonationCategory(
      id: 'livros',
      name: 'Livros',
      icon: Icons.book,
      color: Colors.indigo,
    ),
   const DonationCategory(
      id: 'eletronicos',
      name: 'Eletrônicos',
      icon: Icons.phone_android,
      color: Colors.deepPurple,
    ),
  const  DonationCategory(
      id: 'casa',
      name: 'Casa & Jardim',
      icon: Icons.home,
      color: Colors.teal,
    ),
   const DonationCategory(
      id: 'esporte',
      name: 'Esporte',
      icon: Icons.sports_soccer,
      color: Colors.red,
    ),
  ];

  // Subcategorias específicas para roupas
  static final Map<String, List<DonationCategory>> _subCategories = {
    'roupas': [
     const DonationCategory(
        id: 'camisetas',
        name: 'Camisetas',
        icon: Icons.checkroom,
        color: AppColors.blue_400,
      ),
    const  DonationCategory(
        id: 'camisas',
        name: 'Camisas',
        icon: Icons.dry_cleaning,
        color: AppColors.blue_500,
      ),
    const  DonationCategory(
        id: 'calcas',
        name: 'Calças',
        icon: Icons.accessibility_new,
        color: AppColors.blue_600,
      ),
    const  DonationCategory(
        id: 'shorts',
        name: 'Shorts',
        icon: Icons.checkroom,
        color: AppColors.green_400,
      ),
      DonationCategory(
        id: 'vestidos',
        name: 'Vestidos',
        icon: Icons.checkroom,
        color: Colors.pink.shade300,
      ),
      DonationCategory(
        id: 'casacos',
        name: 'Casacos',
        icon: Icons.checkroom,
        color: Colors.brown.shade400,
      ),
    ],
    'calcados': [
      const DonationCategory(
        id: 'tenis',
        name: 'Tênis',
        icon: Icons.directions_run,
        color: AppColors.green_500,
      ),
     const  DonationCategory(
        id: 'sapatos',
        name: 'Sapatos',
        icon: Icons.shopping_bag_outlined,
        color: Colors.brown,
      ),
      DonationCategory(
        id: 'sandalias',
        name: 'Sandálias',
        icon: Icons.shopping_bag_outlined,
        color: Colors.orange.shade300,
      ),
      DonationCategory(
        id: 'botas',
        name: 'Botas',
        icon: Icons.shopping_bag_outlined,
        color: Colors.grey.shade700,
      ),
    ],
    'acessorios': [
     const  DonationCategory(
        id: 'bolsas',
        name: 'Bolsas',
        icon: Icons.shopping_bag,
        color: AppColors.orange_500,
      ),
     const DonationCategory(
        id: 'cintos',
        name: 'Cintos',
        icon: Icons.linear_scale,
        color: Colors.brown,
      ),
      DonationCategory(
        id: 'joias',
        name: 'Joias',
        icon: Icons.diamond,
        color: Colors.yellow.shade700,
      ),
     const DonationCategory(
        id: 'oculos',
        name: 'Óculos',
        icon: Icons.visibility,
        color: Colors.blueGrey,
      ),
    ],
  };

  static List<DonationCategory> getMainCategories() {
    return List.from(_categories);
  }

  static List<DonationCategory> getSubCategories(String parentCategoryId) {
    return _subCategories[parentCategoryId] ?? [];
  }

  static DonationCategory? getCategoryById(String id) {
    // Procura nas categorias principais
    for (var category in _categories) {
      if (category.id == id) return category;
    }

    // Procura nas subcategorias
    for (var subCategoryList in _subCategories.values) {
      for (var subCategory in subCategoryList) {
        if (subCategory.id == id) return subCategory;
      }
    }

    return null;
  }

  static bool hasSubCategories(String categoryId) {
    return _subCategories.containsKey(categoryId);
  }

  // Mock data para itens de doação salvos
  static List<DonationItem> getMockDonationItems() {
    return [
      DonationItem(
        id: '1',
        categoryId: 'camisetas',
        categoryName: 'Camisetas',
        icon: Icons.checkroom,
        color: AppColors.blue_400,
        quantity: 3,
      ),
      DonationItem(
        id: '2',
        categoryId: 'calcas',
        categoryName: 'Calças',
        icon: Icons.accessibility_new,
        color: AppColors.blue_600,
        quantity: 2,
      ),
      DonationItem(
        id: '3',
        categoryId: 'tenis',
        categoryName: 'Tênis',
        icon: Icons.directions_run,
        color: AppColors.green_500,
        quantity: 1,
      ),
      DonationItem(
        id: '4',
        categoryId: 'custom',
        categoryName: 'Custom',
        icon: Icons.category,
        color: AppColors.orange_500,
        quantity: 1,
        customName: 'Cobertor de lã',
      ),
    ];
  }
}

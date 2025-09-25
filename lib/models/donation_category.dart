import 'package:flutter/material.dart';

class DonationCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const DonationCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class DonationItem {
  final String id;
  final String categoryId;
  final String categoryName;
  final IconData icon;
  final Color color;
  int quantity;
  final String? customName; // Para itens customizados

  DonationItem({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.icon,
    required this.color,
    this.quantity = 1,
    this.customName,
  });

  String get displayName => customName ?? categoryName;
  bool get isCustom => customName != null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'quantity': quantity,
      'customName': customName,
    };
  }

  factory DonationItem.fromMap(Map<String, dynamic> map) {
    return DonationItem(
      id: map['id'],
      categoryId: map['categoryId'],
      categoryName: map['categoryName'],
      icon: Icons.checkroom, // Default icon
      color: Colors.orange, // Default color
      quantity: map['quantity'] ?? 1,
      customName: map['customName'],
    );
  }
}

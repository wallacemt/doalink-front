import 'package:flutter/material.dart';

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione a Categoria'),
      ),
      body: ListView(
        children: [
          _buildCategoryTitle(context, 'Roupas', Icons.checkroom),
          _buildCategoryTitle(context, 'Alimentos', Icons.fastfood),
          _buildCategoryTitle(context, 'Brinquedos', Icons.toys),
          _buildCategoryTitle(context, 'Eletrônicos', Icons.devices),
          _buildCategoryTitle(context, 'Móveis', Icons.chair),
          _buildCategoryTitle(context, 'Outros', Icons.category),
        ],
      ),
    );
  }

  _buildCategoryTitle(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // TODO: Navegar para a tela de adicionar item, passando a categoria
      },
    );
  }
}

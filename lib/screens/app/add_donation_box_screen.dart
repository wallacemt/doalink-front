import 'package:flutter/material.dart';

class AddDonationBoxScreen extends StatefulWidget {
  const AddDonationBoxScreen({super.key});

  @override
  State<AddDonationBoxScreen> createState() => _AddDonationBoxScreen();
}

class _AddDonationBoxScreen extends State<AddDonationBoxScreen> {
  // -------------- MODAL PRE-RENDERIZADO ---------------------
  // Carregar Widget do Modal
  Widget _buildCategorySelectionModal(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (_, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle para o usuário arrastar o modal
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Container(
                  height: 5.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(
                  controller: scrollController,
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  padding: const EdgeInsets.all(2),
                  children: [
                    _buildCategoryItem(context, 'Camisas', Icons.checkroom),
                    _buildCategoryItem(context, 'Calça', Icons.checkroom),
                    _buildCategoryItem(context, 'Camisetas', Icons.checkroom),
                    _buildCategoryItem(context, 'Calça', Icons.checkroom),
                    _buildCategoryItem(context, 'Shorts', Icons.checkroom),
                    _buildCategoryItem(context, 'Casaco', Icons.checkroom),
                    _buildCategoryItem(context, 'Vestido', Icons.checkroom),
                    _buildCategoryItem(context, 'Acessórios', Icons.checkroom),
                    // TODO: IMPLEMENTAR A LÓGICA DO CUSTOMIZAR
                    // _buildCategoryItem(context, 'Custom', Icons.add),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Item individual
  Widget _buildCategoryItem(BuildContext context, String title, IconData icon) {
    return InkWell(
      onTap: () {
        // Retorna o título e a quantidade base da categoria para a tela anterior
        Navigator.pop(context, {'category': title, 'quantity': 1});
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange.withOpacity(0.1),
            radius: 30,
            child: Icon(icon, color: Colors.orange, size: 40),
          ),
          // const SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }
  // -------------- MODAL PRE-RENDERIZADO ---------------------

  bool _isSalvar = false;
  // -------------- lISTA MOCKADOS TESTE BASE ----------------------
  List<Map<String, dynamic>> itensDoacao = [
    {'category': 'Jeans', 'quantity': 1},
    {'category': 'Shorts', 'quantity': 1},
    {'category': 'Jeans', 'quantity': 1},
  ];

  // -------------- lISTA MOCKADOS TESTE ----------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Caixa de Doações',
          style: TextStyle(fontFamily: 'Subtitles'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Botão para confirmar
          TextButton(
            onPressed: () async {
              // TODO: Implementar a lógica de confirmação e envio dos dados ao DB

              // TODO: Não aparecer as opções de regular quantidade do item após salvar
              setState(() {
                _isSalvar = true;
              });
            },
            child: const Text(
              'Salvar',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 27.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'Categoria',
                        style: TextStyle(
                          fontFamily: 'Subtitles',
                          fontSize: 17.5,
                        ),
                      ),
                    )),
                Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Quantidade',
                    style: TextStyle(
                      fontFamily: 'Subtitles',
                      fontSize: 17.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: itensDoacao.isEmpty
                ? const Center(
                    // TODO: Caso remova todos os itens
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Ícone de caixa vazia
                        Icon(
                          Icons.inventory_2_outlined, // TODO: Ícone TEMPORÁRIO
                          size: 100,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Esta é sua caixa de doações',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Adicione itens que você quer doar',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    // TODO: Mostrar itens da LISTA MOCKADA
                    itemCount: itensDoacao.length,
                    itemBuilder: (context, index) {
                      final item = itensDoacao[index];
                      return ListTile(
                        leading: _isSalvar
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.black),
                                onPressed: () {
                                  // TODO: Botão para remover o item da lista
                                  setState(() {
                                    itensDoacao.removeAt(index);
                                  });
                                },
                              ),
                        title: Text(item['category']),
                        trailing: _isSalvar
                            ?
                            // TODO: Se _isSalvar for verdade, mostra apenas a quantidade
                            Text(
                                '${item['quantity']}',
                                style: const TextStyle(fontSize: 18.5),
                              )
                            : SizedBox(
                                // TODO: Caso o contrário, mostra os botões de ajuste da quantidade
                                width: 125,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        // TODO: Diminuir a quantidade do item
                                        setState(() {
                                          if (item['quantity'] > 1) {
                                            item['quantity']--;
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      '${item['quantity']}',
                                      style: const TextStyle(fontSize: 18.5),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        // TODO: Aumentar a quantidade do item
                                        setState(() {
                                          item['quantity']++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                      );
                    },
                  ),
          ),

          // TODO: Botão principal para adicionar mais itens
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF9BA4D), // A cor que você quer
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 68, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                elevation: 4,
              ),
              onPressed: () async {
                // TODO: Espera o resultado da categoria selecionada no modal
                final selectedItem = await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return _buildCategorySelectionModal(context);
                  },
                );
                // TODO: Se um item do modal for selecionado, ele será adicionado à lista
                if (selectedItem != null) {
                  setState(() {
                    itensDoacao.add(selectedItem);
                  });
                }
                // TODO: Se clicar em adicionar item, mostra os objetos: Remover, Aumentar e Diminuir quantidade dos itens
                setState(() {
                  _isSalvar = false;
                });
              },
              child: const Text(
                'ADICIONAR NA CAIXA',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

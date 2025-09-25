import 'package:animate_do/animate_do.dart';
import 'package:doalink/models/donation_category.dart';
import 'package:doalink/theme/app_colors.dart';
import 'package:doalink/utils/donation_category_service.dart';
import 'package:doalink/widgets/donation_box/category_selection_modal.dart';
import 'package:doalink/widgets/donation_box/donation_item_widgets.dart';
import 'package:doalink/widgets/donation_box/empty_donation_box_state.dart';
import 'package:flutter/material.dart';

class AddDonationBoxScreen extends StatefulWidget {
  const AddDonationBoxScreen({super.key});

  @override
  State<AddDonationBoxScreen> createState() => _AddDonationBoxScreenState();
}

class _AddDonationBoxScreenState extends State<AddDonationBoxScreen>
    with TickerProviderStateMixin {
  bool _isEditMode = false;
  List<DonationItem> _donationItems = [];
  late AnimationController _fabAnimationController;
  late Animation<double> _fabScaleAnimation;

  @override
  void initState() {
    super.initState();
    _loadMockData();
    _initializeAnimations();
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fabScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.elasticOut,
    ));
  }

  void _loadMockData() {
    // Carrega dados mock para demonstração
    setState(() {
      _donationItems = DonationCategoryService.getMockDonationItems();
    });
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  void _addNewItem() async {
    _fabAnimationController.forward().then((_) {
      _fabAnimationController.reverse();
    });

    final selectedItem = await showModalBottomSheet<DonationItem>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CategorySelectionModal(),
    );

    if (selectedItem != null && mounted) {
      setState(() {
        _donationItems.add(selectedItem);
        if (!_isEditMode && _donationItems.length == 1) {
          _isEditMode = true;
        }
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _donationItems.removeAt(index);
    });

    // Sair do modo de edição se não houver mais itens
    if (_donationItems.isEmpty) {
      setState(() {
        _isEditMode = false;
      });
    }
  }

  void _updateItemQuantity(int index, int newQuantity) {
    if (newQuantity > 0) {
      setState(() {
        _donationItems[index].quantity = newQuantity;
      });
    }
  }

  void _saveDonationBox() {
    // TODO: Implementar salvamento da caixa de doação
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${_donationItems.length} itens salvos na sua caixa de doação!',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.green_500,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    setState(() {
      _isEditMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cleanCian,
      appBar: _buildAppBar(),
      body: _donationItems.isEmpty
          ? EmptyDonationBoxState(onAddFirstItem: _addNewItem)
          : _buildDonationItemsList(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pushNamed('/home'),
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.black,
        ),
      ),
      title: FadeInDown(
        duration: const Duration(milliseconds: 600),
        child: const Text(
          'Caixa de Doações',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ),
      actions: [
        if (_donationItems.isNotEmpty) ...[
          FadeInDown(
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 100),
            child: IconButton(
              onPressed: _toggleEditMode,
              icon: Icon(
                _isEditMode ? Icons.done : Icons.edit,
                color: _isEditMode ? AppColors.green_500 : AppColors.orange_500,
              ),
              tooltip: _isEditMode ? 'Concluir edição' : 'Editar itens',
            ),
          ),
          if (_isEditMode) ...[
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 200),
              child: TextButton(
                onPressed: _saveDonationBox,
                child:const Text(
                  'Salvar',
                  style: TextStyle(
                    color: AppColors.green_500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ],
    );
  }

  Widget _buildDonationItemsList() {
    return Column(
      children: [
        // Header da lista
        if (!_isEditMode) ...[
          FadeInDown(
            duration: const Duration(milliseconds: 600),
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
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
              child: Row(
                children: [
                  const Icon(
                    Icons.inventory_2,
                    color: AppColors.orange_500,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sua caixa de doação',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          '${_donationItems.length} ${_donationItems.length == 1 ? 'item' : 'itens'} adicionados',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.medianCian,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.green_500.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Pronto para doar',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.green_500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],

        // Lista de itens
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: _donationItems.length,
            itemBuilder: (context, index) {
              final item = _donationItems[index];
              return DonationItemCard(
                item: item,
                isEditMode: _isEditMode,
                animationDelay: index,
                onRemove: () => _removeItem(index),
                onQuantityChanged: (newQuantity) =>
                    _updateItemQuantity(index, newQuantity),
              );
            },
          ),
        ),
        const SizedBox(
          height: 60,
        )
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    if (_donationItems.isEmpty) return const SizedBox.shrink();
    if (_isEditMode) return const SizedBox.shrink();
    return ScaleTransition(
      scale: _fabScaleAnimation,
      child: FloatingActionButton.small(
        onPressed: _addNewItem,
        backgroundColor: AppColors.orange_500,
        foregroundColor: Colors.white,
        elevation: 4,
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
    );
  }
}

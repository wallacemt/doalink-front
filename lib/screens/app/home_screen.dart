import 'package:doalink/theme/app_colors.dart';
import 'package:doalink/widgets/app/home_header.dart';
import 'package:doalink/widgets/app/nearby_ngos_section.dart';
import 'package:doalink/widgets/app/donation_box_section.dart';
import 'package:doalink/widgets/app/quick_actions_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock data - em produção, esses dados viriam de APIs/estado global
  final List<NearbyNgo> _mockNgos = [
    const NearbyNgo(
      id: '1',
      name: 'Casa do Idoso São Vicente',
      description:
          'Cuidando com amor e carinho dos nossos idosos, oferecendo assistência médica e social.',
      distance: 1.2,
      imageUrl: '',
    ),
    const NearbyNgo(
      id: '2',
      name: 'Orfanato Esperança',
      description:
          'Proporcionando educação e cuidado para crianças em situação de vulnerabilidade.',
      distance: 2.5,
      imageUrl: '',
    ),
    const NearbyNgo(
      id: '3',
      name: 'Associação Pão e Vida',
      description:
          'Distribuindo alimentos e oferecendo apoio a famílias em situação de necessidade.',
      distance: 3.1,
      imageUrl: '',
    ),
  ];

  final DonationBoxInfo _mockDonationBox = const DonationBoxInfo(
    itemCount: 3,
    lastItemAdded: 'Roupas infantis',
  );

  late List<QuickAction> _quickActions;

  @override
  void initState() {
    super.initState();
    _initializeQuickActions();
  }

  void _initializeQuickActions() {
    _quickActions = [
      QuickAction(
        id: 'find_ongs',
        title: 'Encontrar ONGs',
        subtitle: 'Descubra ONGs próximas',
        icon: Icons.search_rounded,
        color: AppColors.green_500,
        onTap: () => _navigateToMap(),
      ),
      QuickAction(
        id: 'emergency_help',
        title: 'Ajuda Urgente',
        subtitle: 'Pedidos de emergência',
        icon: Icons.emergency_rounded,
        color: Colors.red.shade400,
        onTap: () => _showEmergencyHelp(),
      ),
      QuickAction(
        id: 'my_donations',
        title: 'Minhas Doações',
        subtitle: 'Histórico e status',
        icon: Icons.history_rounded,
        color: AppColors.blue_500,
        onTap: () => _showDonationHistory(),
      ),
      QuickAction(
        id: 'volunteer',
        title: 'Seja Voluntário',
        subtitle: 'Oportunidades próximas',
        icon: Icons.volunteer_activism_rounded,
        color: AppColors.orange_500,
        onTap: () => _showVolunteerOpportunities(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cleanCian,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: AppColors.orange_500,
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: HomeHeader(
                userName: _getUserName(),
              ),
            ),

            SliverToBoxAdapter(
              child: NearbyNgosSection(
                ngos: _mockNgos,
                onSeeAll: _showAllNgos,
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),

            // Donation Box Section
            SliverToBoxAdapter(
              child: DonationBoxSection(
                donationBoxInfo: _mockDonationBox,
                onSeeMore: _viewDonationBox,
                onAddItem: _addDonationItem,
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),

            // Quick Actions Section
            SliverToBoxAdapter(
              child: QuickActionsSection(
                actions: _quickActions,
              ),
            ),

            // Bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.orange_500,
        foregroundColor: Colors.white,
        onPressed: _addDonationItem,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Doar Item',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Helper methods
  String _getUserName() {
    // Em produção, isso viria do estado de autenticação
    return ''; // Retorna vazio para mostrar mensagem genérica
  }

  Future<void> _refreshData() async {
    // Simula refresh dos dados
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        // Recarregar dados da API
      });
    }
  }

  // Navigation methods
  void _navigateToMap() {
    Navigator.of(context).pushNamed('/map');
  }

  void _viewDonationBox() {
    Navigator.of(context).pushNamed('/donation_box');
  }

  void _addDonationItem() {
    Navigator.of(context).pushNamed('/donation_box');
  }

  void _showAllNgos() {
    Navigator.of(context).pushNamed('/map');
  }

  void _showEmergencyHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.emergency_rounded,
              color: Colors.red.shade400,
            ),
            const SizedBox(width: 8),
            const Text('Ajuda Urgente'),
          ],
        ),
        content: const Text(
          'Esta funcionalidade está em desenvolvimento. Em breve você poderá acessar pedidos de ajuda urgente.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Entendi',
              style:  TextStyle(
                color: AppColors.orange_500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDonationHistory() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Funcionalidade em desenvolvimento'),
        backgroundColor: AppColors.blue_500,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showVolunteerOpportunities() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Oportunidades de voluntariado em breve!'),
        backgroundColor: AppColors.orange_500,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

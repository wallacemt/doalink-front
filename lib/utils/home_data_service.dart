// Serviço para gerenciar dados da home screen
// Em produção, este serviço faria chamadas para APIs reais

import 'package:doalink/widgets/app/nearby_ngos_section.dart';
import 'package:doalink/widgets/app/donation_box_section.dart';

class HomeDataService {
  // Simulação de dados de localização
  static Future<List<NearbyNgo>> fetchNearbyNgos({
    double? latitude,
    double? longitude,
    int limit = 10,
  }) async {
    // Simula delay de rede
    await Future.delayed(const Duration(milliseconds: 800));

    // Em produção, faria uma chamada para API:
    // final response = await http.get(
    //   Uri.parse('$baseUrl/ngos/nearby?lat=$latitude&lon=$longitude&limit=$limit'),
    //   headers: {'Authorization': 'Bearer $token'},
    // );

    return [
      const NearbyNgo(
        id: '1',
        name: 'Casa do Idoso São Vicente',
        description:
            'Cuidando com amor e carinho dos nossos idosos, oferecendo assistência médica e social.',
        distance: 1.2,
        imageUrl: 'https://example.com/casa-do-idoso.jpg',
     
      ),
      const NearbyNgo(
        id: '2',
        name: 'Orfanato Esperança',
        description:
            'Proporcionando educação e cuidado para crianças em situação de vulnerabilidade.',
        distance: 2.5,
        imageUrl: 'https://example.com/orfanato-esperanca.jpg',
       
      ),
      const NearbyNgo(
        id: '3',
        name: 'Associação Pão e Vida',
        description:
            'Distribuindo alimentos e oferecendo apoio a famílias em situação de necessidade.',
        distance: 3.1,
        imageUrl: 'https://example.com/pao-e-vida.jpg',
      
      ),
      const NearbyNgo(
        id: '4',
        name: 'Centro de Reabilitação Esperança',
        description:
            'Oferecendo tratamento e reabilitação para pessoas com dependência química.',
        distance: 4.2,
        imageUrl: 'https://example.com/centro-reabilitacao.jpg',
      
      ),
    ];
  }

  // Simulação de dados da caixa de doação do usuário
  static Future<DonationBoxInfo?> fetchUserDonationBox(String userId) async {
    await Future.delayed(const Duration(milliseconds: 600));

    // Em produção, faria uma chamada para API:
    // final response = await http.get(
    //   Uri.parse('$baseUrl/users/$userId/donation-box'),
    //   headers: {'Authorization': 'Bearer $token'},
    // );

    // Simula usuário com itens na caixa
    return const DonationBoxInfo(
      itemCount: 3,
      lastItemAdded: 'Roupas infantis',
      lastUpdate: null, // DateTime.now().subtract(Duration(hours: 2)),
    );

    // Para usuário sem itens, retornaria:
    // return const DonationBoxInfo(
    //   itemCount: 0,
    //   lastItemAdded: '',
    // );
  }

  // Simulação de busca por emergências próximas
  static Future<int> fetchEmergencyCount({
    double? latitude,
    double? longitude,
    double radiusKm = 10.0,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    // Em produção:
    // final response = await http.get(
    //   Uri.parse('$baseUrl/emergencies/count?lat=$latitude&lon=$longitude&radius=$radiusKm'),
    //   headers: {'Authorization': 'Bearer $token'},
    // );

    return 7; // Número de emergências ativas na região
  }

  // Simulação de estatísticas do usuário
  static Future<Map<String, dynamic>> fetchUserStats(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'totalDonations': 12,
      'helpedFamilies': 8,
      'volunteerHours': 24,
      'impactScore': 85,
    };
  }

  // Simulação de dados de geolocalização
  static Future<Map<String, double>?> getCurrentLocation() async {
    // Em produção, usaria o Geolocator:
    // try {
    //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //   if (!serviceEnabled) return null;
    //
    //   LocationPermission permission = await Geolocator.checkPermission();
    //   if (permission == LocationPermission.denied) {
    //     permission = await Geolocator.requestPermission();
    //     if (permission == LocationPermission.denied) return null;
    //   }
    //
    //   Position position = await Geolocator.getCurrentPosition();
    //   return {
    //     'latitude': position.latitude,
    //     'longitude': position.longitude,
    //   };
    // } catch (e) {
    //   return null;
    // }

    // Mock de localização (São Paulo)
    await Future.delayed(const Duration(milliseconds: 1000));
    return {
      'latitude': -23.5505,
      'longitude': -46.6333,
    };
  }
}

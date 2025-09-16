import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get googleMapsApiKey {
    return dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
  }

  static String get apiBaseUrl {
    return dotenv.env['API_BASE_URL'] ?? 'https://api.doalink.com';
  }

  static bool get isDebugMode {
    return dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';
  }

  static bool get isConfigValid {
    return googleMapsApiKey.isNotEmpty;
  }

  static Map<String, dynamic> getConfigStatus() {
    return {
      'googleMapsApiKey':
          googleMapsApiKey.isNotEmpty ? 'CONFIGURADO' : 'NÃO CONFIGURADO',
      'apiBaseUrl': apiBaseUrl,
      'isDebugMode': isDebugMode,
      'isConfigValid': isConfigValid,
    };
  }
}

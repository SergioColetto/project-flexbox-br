import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class Config {
  static String get googleKey => _get('GOOGLE_API_KEY');

  static String _get(String name) => DotEnv.env[name] ?? '';
}

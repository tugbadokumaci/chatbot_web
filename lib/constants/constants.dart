import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  Constants._();
}

const String chatRoute = '/chat';

class ApiConstants {
  ApiConstants._();
  static const String BASE_URL = "https://api.openai.com/v1";
  static String API_KEY = dotenv.env['API_KEY'] ?? '';
}

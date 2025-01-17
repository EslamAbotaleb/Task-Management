import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

const BASE_URL = "https://dummyjson.com";
const String SERVER_FAILURE_MESSAGE = 'Please try again later .';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();
Future<bool> checkUserLoggedIn() async {
  // Retrieve the token from secure storage
  final String? token = await secureStorage.read(key: 'accessToken');
  return token != null && token.isNotEmpty; // User is logged in if token exists
}

Logger logger = Logger(
  printer: PrettyPrinter(
    printTime: true,
    methodCount: 1,
    errorMethodCount: 2,
    colors: false,
  ),
);

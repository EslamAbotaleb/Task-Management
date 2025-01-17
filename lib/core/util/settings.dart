import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const BASE_URL = "https://dummyjson.com";
const String SERVER_FAILURE_MESSAGE = 'Please try again later .';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();
Future<bool> checkUserLoggedIn() async {
  // Retrieve the token from secure storage
  final String? token = await secureStorage.read(key: 'accessToken');
  return token != null && token.isNotEmpty; // User is logged in if token exists
}

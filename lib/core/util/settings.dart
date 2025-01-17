import 'package:logger/logger.dart';
import 'package:task_mangement/core/util/constants.dart';

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

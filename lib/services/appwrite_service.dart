import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class AppwriteService {
  static final Client client = Client()
    ..setEndpoint(
        'https://fra.cloud.appwrite.io/v1') // ← Your Appwrite API Endpoint
    ..setProject('68257b900016c23156eb') // ← Your Project ID
    ..setSelfSigned(status: true); // Optional: only for local dev / self-hosted

  static final Account account = Account(client);

  static Future<void> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    await account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );
  }

  // Login
  static Future<void> login({
    required String email,
    required String password,
  }) async {
    await account.createEmailPasswordSession(
      email: email,
      password: password,
    );
  }

  // Get current user
  static Future<models.User> getCurrentUser() async {
    return await account.get();
  }

  // Logout
  static Future<void> logout() async {
    await account.deleteSession(sessionId: 'current');
  }
}

// how to use
// void yourFunction() {
//   final client = AppwriteService.client;

//   // Example usage with Account API
//   final account = Account(client);
//   // await account.createSession(...);
// }

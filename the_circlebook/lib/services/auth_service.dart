import '../config/api_config.dart';
import '../models/circlebook_models.dart';
import 'api_service.dart';
import 'storage_service.dart';

/// AuthService coordinates authentication and session state.
/// Connects to POST /api/auth/login and POST /api/auth/register on Node.js backend.
class AuthService {
  static CircleUser? _cachedUser;
  static CircleUser? _testUser;

  /// Allows setting a test user fixture for automated testing
  static void setTestUser(CircleUser? user) {
    _testUser = user;
    _cachedUser = user;
  }

  /// Current authenticated user (null if not logged in)
  static CircleUser? get currentUser {
    if (_testUser != null) return _testUser;
    _cachedUser ??= StorageService.loadCurrentUser();
    return _cachedUser;
  }

  /// Whether a valid user session is active
  static bool get isAuthenticated {
    if (_testUser != null) return true;
    return StorageService.loadLoggedIn();
  }

  /// Sign in with credentials via Node.js + Express backend
  static Future<CircleUser> login(String email, String password) async {
    final response = await ApiService.post(
      ApiConfig.authLogin,
      body: {
        'email': email.trim(),
        'password': password,
      },
    );

    if (response is Map<String, dynamic>) {
      final token = response['token']?.toString() ?? response['accessToken']?.toString() ?? '';
      if (token.isNotEmpty) {
        await StorageService.saveAuthToken(token);
      }

      final userData = response['user'] ?? response['data'];
      if (userData is Map<String, dynamic>) {
        final user = CircleUser.fromJson(userData);
        _cachedUser = user;
        await StorageService.saveCurrentUser(user);
        return user;
      }
    }

    // Fallback to fetch current user profile
    return await fetchCurrentUser();
  }

  /// Register new user account via backend API
  static Future<CircleUser> register({
    required String name,
    required String handle,
    required String email,
    required String password,
  }) async {
    final response = await ApiService.post(
      ApiConfig.authRegister,
      body: {
        'name': name.trim(),
        'handle': handle.startsWith('@') ? handle.trim() : '@${handle.trim()}',
        'email': email.trim(),
        'password': password,
      },
    );

    if (response is Map<String, dynamic>) {
      final token = response['token']?.toString() ?? response['accessToken']?.toString() ?? '';
      if (token.isNotEmpty) {
        await StorageService.saveAuthToken(token);
      }

      final userData = response['user'] ?? response['data'];
      if (userData is Map<String, dynamic>) {
        final user = CircleUser.fromJson(userData);
        _cachedUser = user;
        await StorageService.saveCurrentUser(user);
        return user;
      }
    }

    return await fetchCurrentUser();
  }

  /// Fetch currently authenticated user profile from GET /api/users/me
  static Future<CircleUser> fetchCurrentUser() async {
    final response = await ApiService.get(ApiConfig.currentUser);
    final data = (response is Map && response['user'] != null)
        ? response['user'] as Map<String, dynamic>
        : (response is Map && response['data'] != null)
            ? response['data'] as Map<String, dynamic>
            : response as Map<String, dynamic>;

    final user = CircleUser.fromJson(data);
    _cachedUser = user;
    await StorageService.saveCurrentUser(user);
    return user;
  }

  /// Log out and terminate session
  static Future<void> logout() async {
    try {
      await ApiService.post(ApiConfig.authLogout);
    } catch (_) {
      // Ignore network errors on logout
    }
    _cachedUser = null;
    _testUser = null;
    await StorageService.logout();
  }
}

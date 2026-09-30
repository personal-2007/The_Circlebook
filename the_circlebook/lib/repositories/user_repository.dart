import '../config/api_config.dart';
import '../models/circlebook_models.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

/// UserRepository manages user profiles, connections, and directory queries.
/// Communicates through ApiService to the Node.js + Express + MySQL backend.
class UserRepository {
  static List<CircleUser>? _testUsers;

  /// Sets test fixtures for isolated unit and widget tests
  static void setTestUsers(List<CircleUser>? users) {
    _testUsers = users;
  }

  /// Get currently authenticated user profile from GET /api/users/me
  Future<CircleUser> getCurrentUser() async {
    return await AuthService.fetchCurrentUser();
  }

  /// Update the current user's profile
  Future<CircleUser> updateProfile(CircleUser user) async {
    final response = await ApiService.put(
      ApiConfig.currentUser,
      body: user.toJson(),
    );

    final data = (response is Map && response['user'] != null)
        ? response['user'] as Map<String, dynamic>
        : (response is Map && response['data'] != null)
            ? response['data'] as Map<String, dynamic>
            : response as Map<String, dynamic>;

    return CircleUser.fromJson(data);
  }

  /// Search and discover people
  /// Backend endpoint: GET /api/users?query=...&filter=...
  Future<List<CircleUser>> getPeople({String? query, int filter = 0}) async {
    if (_testUsers != null) {
      return List<CircleUser>.from(_testUsers!);
    }

    final queryParams = <String, dynamic>{'filter': filter};
    if (query != null && query.isNotEmpty) {
      queryParams['query'] = query;
    }

    final response = await ApiService.get(
      ApiConfig.users,
      queryParams: queryParams,
    );

    if (response is List) {
      return response
          .map((item) => CircleUser.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['users'] is List) {
      return (response['users'] as List)
          .map((item) => CircleUser.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['data'] is List) {
      return (response['data'] as List)
          .map((item) => CircleUser.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Get user's verified connections (friends)
  /// Backend endpoint: GET /api/users/me/connections
  Future<List<CircleUser>> getConnections() async {
    if (_testUsers != null) {
      return _testUsers!.where((u) => u.isConnected).toList();
    }

    final response = await ApiService.get(ApiConfig.userConnections);
    if (response is List) {
      return response
          .map((item) => CircleUser.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['connections'] is List) {
      return (response['connections'] as List)
          .map((item) => CircleUser.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Get incoming connection requests
  /// Backend endpoint: GET /api/users/me/requests
  Future<List<CircleFriendRequest>> getFriendRequests() async {
    final response = await ApiService.get(ApiConfig.friendRequests);
    if (response is List) {
      return response
          .map((item) => CircleFriendRequest.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['requests'] is List) {
      return (response['requests'] as List)
          .map((item) => CircleFriendRequest.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Block a user
  Future<void> blockUser(String userId) async {
    await ApiService.post('/users/$userId/block');
  }
}

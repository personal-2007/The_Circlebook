import '../config/api_config.dart';
import '../models/circlebook_models.dart';
import '../services/api_service.dart';

/// CommunityRepository handles groups, events, explore media, and marketplace items.
/// Communicates through ApiService to the Node.js + Express + MySQL backend.
class CommunityRepository {
  static List<CircleCommunity>? _testGroups;
  static List<CircleEvent>? _testEvents;

  /// Sets test fixtures for tests
  static void setTestFixtures({
    List<CircleCommunity>? groups,
    List<CircleEvent>? events,
  }) {
    _testGroups = groups;
    _testEvents = events;
  }

  /// Get groups and subject guilds from backend API
  /// Backend endpoint: GET /api/groups
  Future<List<CircleCommunity>> getGroups() async {
    if (_testGroups != null) return List.from(_testGroups!);

    final response = await ApiService.get(ApiConfig.groups);
    if (response is List) {
      return response
          .map((item) => CircleCommunity.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['groups'] is List) {
      return (response['groups'] as List)
          .map((item) => CircleCommunity.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Get events and colloquia from backend API
  /// Backend endpoint: GET /api/events
  Future<List<CircleEvent>> getEvents() async {
    if (_testEvents != null) return List.from(_testEvents!);

    final response = await ApiService.get(ApiConfig.events);
    if (response is List) {
      return response
          .map((item) => CircleEvent.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['events'] is List) {
      return (response['events'] as List)
          .map((item) => CircleEvent.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Get video lectures from backend API
  /// Backend endpoint: GET /api/explore/watch
  Future<List<CircleWatchItem>> getWatchItems() async {
    final response = await ApiService.get(ApiConfig.watchItems);
    if (response is List) {
      return response
          .map((item) => CircleWatchItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['items'] is List) {
      return (response['items'] as List)
          .map((item) => CircleWatchItem.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Get marketplace items from backend API
  /// Backend endpoint: GET /api/explore/marketplace
  Future<List<CircleMarketItem>> getMarketItems() async {
    final response = await ApiService.get(ApiConfig.marketItems);
    if (response is List) {
      return response
          .map((item) => CircleMarketItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['items'] is List) {
      return (response['items'] as List)
          .map((item) => CircleMarketItem.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Get memories from backend API
  /// Backend endpoint: GET /api/activity/memories
  Future<List<CircleMemory>> getMemories() async {
    final response = await ApiService.get(ApiConfig.memories);
    if (response is List) {
      return response
          .map((item) => CircleMemory.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['memories'] is List) {
      return (response['memories'] as List)
          .map((item) => CircleMemory.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Get active login sessions from backend API
  /// Backend endpoint: GET /api/settings/sessions
  Future<List<SessionDevice>> getActiveSessions() async {
    final response = await ApiService.get(ApiConfig.activeSessions);
    if (response is List) {
      return response
          .map((item) => SessionDevice.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['sessions'] is List) {
      return (response['sessions'] as List)
          .map((item) => SessionDevice.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Terminate a session
  /// Backend endpoint: DELETE /api/settings/sessions/:id
  Future<void> terminateSession(String sessionId) async {
    await ApiService.delete(ApiConfig.terminateSession(sessionId));
  }
}

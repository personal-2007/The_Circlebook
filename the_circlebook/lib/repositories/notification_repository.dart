import '../config/api_config.dart';
import '../models/circlebook_models.dart';
import '../services/api_service.dart';

/// NotificationRepository handles retrieval and state updates of notifications.
/// Communicates through ApiService to the Node.js + Express + MySQL backend.
class NotificationRepository {
  static List<CircleNotification>? _testNotifications;

  static void setTestNotifications(List<CircleNotification>? notifications) {
    _testNotifications = notifications;
  }

  /// Retrieve notifications
  /// Backend endpoint: GET /api/notifications
  Future<List<CircleNotification>> getNotifications() async {
    if (_testNotifications != null) return List.from(_testNotifications!);

    final response = await ApiService.get(ApiConfig.notifications);
    if (response is List) {
      return response
          .map((item) => CircleNotification.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['notifications'] is List) {
      return (response['notifications'] as List)
          .map((item) => CircleNotification.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Mark all notifications as read
  /// Backend endpoint: POST /api/notifications/read-all
  Future<void> markAllAsRead() async {
    await ApiService.post(ApiConfig.markNotificationsRead);
    if (_testNotifications != null) {
      _testNotifications = _testNotifications!
          .map((n) => n.copyWith(isUnread: false))
          .toList();
    }
  }
}

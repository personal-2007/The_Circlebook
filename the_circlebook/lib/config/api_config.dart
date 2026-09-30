/// API Configuration for The Circlebook.
/// Connects Flutter to the Node.js + Express + MySQL REST API backend.
/// Note: Flutter communicates exclusively via secure REST APIs.
/// Flutter NEVER connects directly to MySQL and stores NO DB credentials.
class ApiConfig {
  ApiConfig._();

  /// Base API URL. Can be overridden via environment: --dart-define=API_BASE_URL=https://api.circlebook.org/api
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000/api',
  );

  /// Authentication endpoints
  static const String authLogin = '/auth/login';
  static const String authRegister = '/auth/register';
  static const String authLogout = '/auth/logout';
  static const String authRefresh = '/auth/refresh';

  /// User endpoints
  static const String currentUser = '/users/me';
  static const String users = '/users';
  static String userProfile(String id) => '/users/$id';
  static const String userConnections = '/users/me/connections';
  static const String friendRequests = '/users/me/requests';

  /// Feed & Post endpoints
  static const String feed = '/posts/feed';
  static const String posts = '/posts';
  static String postDetail(String id) => '/posts/$id';
  static String postComments(String id) => '/posts/$id/comments';
  static String postLike(String id) => '/posts/$id/like';
  static String postSave(String id) => '/posts/$id/save';

  /// Communities & Events endpoints
  static const String groups = '/groups';
  static String groupDetail(String id) => '/groups/$id';
  static const String events = '/events';
  static String eventDetail(String id) => '/events/$id';

  /// Communications
  static const String messages = '/messages';
  static String conversation(String id) => '/messages/conversations/$id';
  static const String notifications = '/notifications';
  static const String markNotificationsRead = '/notifications/read-all';

  /// Activity & Explore
  static const String savedItems = '/activity/saved';
  static const String memories = '/activity/memories';
  static const String watchItems = '/explore/watch';
  static const String marketItems = '/explore/marketplace';

  /// Settings
  static const String privacySettings = '/settings/privacy';
  static const String activeSessions = '/settings/sessions';
  static String terminateSession(String id) => '/settings/sessions/$id';

  /// Request timeout duration
  static const Duration requestTimeout = Duration(seconds: 15);
}

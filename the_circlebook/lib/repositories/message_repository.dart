import '../config/api_config.dart';
import '../models/circlebook_models.dart';
import '../services/api_service.dart';

/// MessageRepository handles direct messaging communications.
/// Communicates through ApiService to the Node.js + Express + MySQL backend.
class MessageRepository {
  static List<CircleMessage>? _testMessages;

  static void setTestMessages(List<CircleMessage>? messages) {
    _testMessages = messages;
  }

  /// Retrieve active conversations
  /// Backend endpoint: GET /api/messages
  Future<List<CircleMessage>> getMessages() async {
    if (_testMessages != null) return List.from(_testMessages!);

    final response = await ApiService.get(ApiConfig.messages);
    if (response is List) {
      return response
          .map((item) => CircleMessage.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['messages'] is List) {
      return (response['messages'] as List)
          .map((item) => CircleMessage.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Send message in conversation
  /// Backend endpoint: POST /api/messages
  Future<CircleMessage> sendMessage(String conversationId, String content) async {
    final response = await ApiService.post(
      ApiConfig.messages,
      body: {
        'conversationId': conversationId,
        'content': content,
      },
    );

    final data = (response is Map && response['message'] != null)
        ? response['message'] as Map<String, dynamic>
        : (response is Map && response['data'] != null)
            ? response['data'] as Map<String, dynamic>
            : response as Map<String, dynamic>;

    return CircleMessage.fromJson(data);
  }

  /// Archive a conversation
  Future<void> archiveConversation(String messageId) async {
    await ApiService.post('/messages/$messageId/archive');
  }
}

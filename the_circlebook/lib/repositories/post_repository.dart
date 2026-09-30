import '../config/api_config.dart';
import '../models/circlebook_models.dart';
import '../services/api_service.dart';

/// PostRepository coordinates retrieval and mutation of posts and comments.
/// Communicates through ApiService to the Node.js + Express + MySQL backend.
/// Never falls back silently to demo data.
class PostRepository {
  static List<CirclePost>? _testPosts;

  /// Sets test fixtures for isolated unit and widget tests
  static void setTestPosts(List<CirclePost>? posts) {
    _testPosts = posts;
  }

  /// Retrieves the current feed posts filtered by algorithm.
  /// Backend endpoint: GET /api/posts/feed?algorithm=for_you
  Future<List<CirclePost>> getFeed({String algorithm = 'for_you'}) async {
    if (_testPosts != null) {
      if (algorithm == 'following') {
        return _testPosts!.reversed.toList();
      }
      return List<CirclePost>.from(_testPosts!);
    }

    final response = await ApiService.get(
      ApiConfig.feed,
      queryParams: {'algorithm': algorithm},
    );

    if (response is List) {
      return response
          .map((item) => CirclePost.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['posts'] is List) {
      return (response['posts'] as List)
          .map((item) => CirclePost.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['data'] is List) {
      return (response['data'] as List)
          .map((item) => CirclePost.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Create a new post via backend API.
  /// Backend endpoint: POST /api/posts
  Future<CirclePost> createPost({
    required String content,
    List<String> tags = const [],
    String audience = 'Circles Only',
    String? imageUrl,
  }) async {
    final response = await ApiService.post(
      ApiConfig.posts,
      body: {
        'content': content,
        'tags': tags,
        'audience': audience,
        'imageUrl': imageUrl,
      },
    );

    final data = (response is Map && response['post'] != null)
        ? response['post'] as Map<String, dynamic>
        : (response is Map && response['data'] != null)
            ? response['data'] as Map<String, dynamic>
            : response as Map<String, dynamic>;

    final created = CirclePost.fromJson(data);

    if (_testPosts != null) {
      _testPosts!.insert(0, created);
    }
    return created;
  }

  /// Retrieve comments for a post.
  /// Backend endpoint: GET /api/posts/:id/comments
  Future<List<CircleComment>> getComments(String postId) async {
    final response = await ApiService.get(ApiConfig.postComments(postId));
    if (response is List) {
      return response
          .map((c) => CircleComment.fromJson(c as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['comments'] is List) {
      return (response['comments'] as List)
          .map((c) => CircleComment.fromJson(c as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Post a new comment.
  /// Backend endpoint: POST /api/posts/:id/comments
  Future<CircleComment> addComment(String postId, String content) async {
    final response = await ApiService.post(
      ApiConfig.postComments(postId),
      body: {'content': content},
    );

    final data = (response is Map && response['comment'] != null)
        ? response['comment'] as Map<String, dynamic>
        : (response is Map && response['data'] != null)
            ? response['data'] as Map<String, dynamic>
            : response as Map<String, dynamic>;

    return CircleComment.fromJson(data);
  }

  /// Toggle like on a post.
  /// Backend endpoint: POST /api/posts/:id/like
  Future<void> toggleLike(String postId) async {
    await ApiService.post(ApiConfig.postLike(postId));
  }

  /// Toggle save post for later reading.
  /// Backend endpoint: POST /api/posts/:id/save
  Future<void> toggleSave(String postId) async {
    await ApiService.post(ApiConfig.postSave(postId));
  }

  /// Delete a post.
  /// Backend endpoint: DELETE /api/posts/:id
  Future<void> deletePost(String postId) async {
    await ApiService.delete(ApiConfig.postDetail(postId));
    _testPosts?.removeWhere((p) => p.id == postId);
  }

  /// Get user's saved posts.
  /// Backend endpoint: GET /api/activity/saved
  Future<List<CirclePost>> getSavedPosts() async {
    final response = await ApiService.get(ApiConfig.savedItems);
    if (response is List) {
      return response
          .map((item) => CirclePost.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic> && response['saved'] is List) {
      return (response['saved'] as List)
          .map((item) => CirclePost.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}

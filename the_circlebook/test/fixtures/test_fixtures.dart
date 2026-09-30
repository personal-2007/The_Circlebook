import 'package:the_circlebook/models/circlebook_models.dart';

/// Test fixtures isolated exclusively inside the test/ directory.
/// These fixtures are never included in production runtime.
class TestFixtures {
  static const CircleUser testUser = CircleUser(
    id: 'test_usr_001',
    name: 'Test Member',
    handle: '@test_member',
    avatarUrl: '',
    headline: 'Software Engineer & Research Fellow',
    location: 'Test City',
    about: 'Automated test fixture profile.',
    role: 'member',
    college: 'Engineering Institute',
    skills: ['Dart', 'Flutter', 'Testing'],
    interests: ['Systems', 'Design'],
    circleCount: 5,
    followerCount: 10,
    postCount: 2,
    isConnected: true,
  );

  static const List<CirclePost> testPosts = [
    CirclePost(
      id: 'test_post_001',
      authorId: 'test_usr_001',
      authorName: 'Test Member',
      authorHandle: '@test_member',
      authorAvatarUrl: '',
      timestamp: '1 hour ago',
      content: 'This is an isolated test post fixture for automated verification.',
      likes: 1,
      comments: 0,
      shares: 0,
      tags: ['#Testing'],
      isLiked: false,
    ),
    CirclePost(
      id: 'test_post_002',
      authorId: 'test_usr_002',
      authorName: 'Second Member',
      authorHandle: '@second_member',
      authorAvatarUrl: '',
      timestamp: '2 hours ago',
      content: 'Second post fixture for feed sorting algorithms.',
      likes: 3,
      comments: 1,
      shares: 0,
      tags: ['#Engineering'],
      isLiked: true,
    ),
  ];

  static const List<CircleNotification> testNotifications = [];
  static const List<CircleMessage> testMessages = [];
  static const List<CircleCommunity> testGroups = [];
  static const List<CircleEvent> testEvents = [];
}

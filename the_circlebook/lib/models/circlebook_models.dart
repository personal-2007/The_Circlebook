import 'package:flutter/material.dart';

/// Aliases for standard naming compatibility
typedef User = CircleUser;
typedef Post = CirclePost;
typedef Comment = CircleComment;
typedef Friend = CircleFriend;
typedef FriendRequest = CircleFriendRequest;
typedef Story = CircleStory;
typedef Group = CircleCommunity;
typedef Event = CircleEvent;
typedef Message = CircleMessage;
typedef Notification = CircleNotification;
typedef SavedItem = CircleSavedItem;

/// Authenticated user / member profile model.
/// Deserializes directly from backend MySQL responses.
class CircleUser {
  final String id;
  final String name;
  final String handle;
  final String avatarUrl;
  final String headline;
  final String location;
  final String about;
  final String role;
  final String college;
  final List<String> skills;
  final List<String> interests;
  final int circleCount;
  final int followerCount;
  final int postCount;
  final bool isConnected;
  final bool isBlocked;
  final bool isRestricted;

  const CircleUser({
    required this.id,
    required this.name,
    required this.handle,
    this.avatarUrl = '',
    this.headline = '',
    this.location = '',
    this.about = '',
    this.role = 'member',
    this.college = '',
    this.skills = const [],
    this.interests = const [],
    this.circleCount = 0,
    this.followerCount = 0,
    this.postCount = 0,
    this.isConnected = false,
    this.isBlocked = false,
    this.isRestricted = false,
  });

  factory CircleUser.fromJson(Map<String, dynamic> json) {
    return CircleUser(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      handle: json['handle']?.toString() ?? '',
      avatarUrl: json['avatarUrl']?.toString() ?? json['avatar_url']?.toString() ?? '',
      headline: json['headline']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      about: json['about']?.toString() ?? json['bio']?.toString() ?? '',
      role: json['role']?.toString() ?? 'member',
      college: json['college']?.toString() ?? json['education']?.toString() ?? '',
      skills: (json['skills'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
      interests: (json['interests'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
      circleCount: (json['circleCount'] ?? json['circle_count'] ?? 0) as int,
      followerCount: (json['followerCount'] ?? json['follower_count'] ?? 0) as int,
      postCount: (json['postCount'] ?? json['post_count'] ?? 0) as int,
      isConnected: json['isConnected'] == true || json['is_connected'] == 1,
      isBlocked: json['isBlocked'] == true || json['is_blocked'] == 1,
      isRestricted: json['isRestricted'] == true || json['is_restricted'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'handle': handle,
      'avatarUrl': avatarUrl,
      'headline': headline,
      'location': location,
      'about': about,
      'role': role,
      'college': college,
      'skills': skills,
      'interests': interests,
      'circleCount': circleCount,
      'followerCount': followerCount,
      'postCount': postCount,
      'isConnected': isConnected,
      'isBlocked': isBlocked,
      'isRestricted': isRestricted,
    };
  }

  CircleUser copyWith({
    String? id,
    String? name,
    String? handle,
    String? avatarUrl,
    String? headline,
    String? location,
    String? about,
    String? role,
    String? college,
    List<String>? skills,
    List<String>? interests,
    int? circleCount,
    int? followerCount,
    int? postCount,
    bool? isConnected,
    bool? isBlocked,
    bool? isRestricted,
  }) {
    return CircleUser(
      id: id ?? this.id,
      name: name ?? this.name,
      handle: handle ?? this.handle,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      headline: headline ?? this.headline,
      location: location ?? this.location,
      about: about ?? this.about,
      role: role ?? this.role,
      college: college ?? this.college,
      skills: skills ?? this.skills,
      interests: interests ?? this.interests,
      circleCount: circleCount ?? this.circleCount,
      followerCount: followerCount ?? this.followerCount,
      postCount: postCount ?? this.postCount,
      isConnected: isConnected ?? this.isConnected,
      isBlocked: isBlocked ?? this.isBlocked,
      isRestricted: isRestricted ?? this.isRestricted,
    );
  }
}

/// Feed post model.
class CirclePost {
  final String id;
  final String authorId;
  final String authorName;
  final String authorHandle;
  final String authorAvatarUrl;
  final String timestamp;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;
  final int shares;
  final List<String> tags;
  final bool isLiked;
  final bool isSaved;
  final bool isNotificationsOn;
  final String? algorithmReason;

  const CirclePost({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.authorHandle,
    this.authorAvatarUrl = '',
    required this.timestamp,
    required this.content,
    this.imageUrl,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.tags = const [],
    this.isLiked = false,
    this.isSaved = false,
    this.isNotificationsOn = true,
    this.algorithmReason,
  });

  factory CirclePost.fromJson(Map<String, dynamic> json) {
    return CirclePost(
      id: json['id']?.toString() ?? '',
      authorId: json['authorId']?.toString() ?? json['author_id']?.toString() ?? '',
      authorName: json['authorName']?.toString() ?? json['author_name']?.toString() ?? '',
      authorHandle: json['authorHandle']?.toString() ?? json['author_handle']?.toString() ?? '',
      authorAvatarUrl: json['authorAvatarUrl']?.toString() ?? json['author_avatar_url']?.toString() ?? '',
      timestamp: json['timestamp']?.toString() ?? json['created_at']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? json['image_url']?.toString(),
      likes: (json['likes'] ?? json['like_count'] ?? 0) as int,
      comments: (json['comments'] ?? json['comment_count'] ?? 0) as int,
      shares: (json['shares'] ?? json['share_count'] ?? 0) as int,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
      isLiked: json['isLiked'] == true || json['is_liked'] == 1,
      isSaved: json['isSaved'] == true || json['is_saved'] == 1,
      isNotificationsOn: json['isNotificationsOn'] ?? json['is_notifications_on'] ?? true,
      algorithmReason: json['algorithmReason']?.toString() ?? json['algorithm_reason']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorId': authorId,
      'authorName': authorName,
      'authorHandle': authorHandle,
      'authorAvatarUrl': authorAvatarUrl,
      'timestamp': timestamp,
      'content': content,
      'imageUrl': imageUrl,
      'likes': likes,
      'comments': comments,
      'shares': shares,
      'tags': tags,
      'isLiked': isLiked,
      'isSaved': isSaved,
      'isNotificationsOn': isNotificationsOn,
      'algorithmReason': algorithmReason,
    };
  }

  CirclePost copyWith({
    String? id,
    String? authorId,
    String? authorName,
    String? authorHandle,
    String? authorAvatarUrl,
    String? timestamp,
    String? content,
    String? imageUrl,
    int? likes,
    int? comments,
    int? shares,
    List<String>? tags,
    bool? isLiked,
    bool? isSaved,
    bool? isNotificationsOn,
    String? algorithmReason,
  }) {
    return CirclePost(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorHandle: authorHandle ?? this.authorHandle,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      timestamp: timestamp ?? this.timestamp,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      tags: tags ?? this.tags,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      isNotificationsOn: isNotificationsOn ?? this.isNotificationsOn,
      algorithmReason: algorithmReason ?? this.algorithmReason,
    );
  }
}

/// Comment model on a post.
class CircleComment {
  final String id;
  final String postId;
  final String authorName;
  final String authorHandle;
  final String content;
  final String timestamp;
  final int likes;
  final bool isAuthor;
  final bool isSaved;

  const CircleComment({
    required this.id,
    required this.postId,
    required this.authorName,
    required this.authorHandle,
    required this.content,
    required this.timestamp,
    this.likes = 0,
    this.isAuthor = false,
    this.isSaved = false,
  });

  factory CircleComment.fromJson(Map<String, dynamic> json) {
    return CircleComment(
      id: json['id']?.toString() ?? '',
      postId: json['postId']?.toString() ?? json['post_id']?.toString() ?? '',
      authorName: json['authorName']?.toString() ?? json['author_name']?.toString() ?? '',
      authorHandle: json['authorHandle']?.toString() ?? json['author_handle']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      timestamp: json['timestamp']?.toString() ?? json['created_at']?.toString() ?? '',
      likes: (json['likes'] ?? 0) as int,
      isAuthor: json['isAuthor'] == true || json['is_author'] == 1,
      isSaved: json['isSaved'] == true || json['is_saved'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'authorName': authorName,
      'authorHandle': authorHandle,
      'content': content,
      'timestamp': timestamp,
      'likes': likes,
      'isAuthor': isAuthor,
      'isSaved': isSaved,
    };
  }

  CircleComment copyWith({
    String? id,
    String? postId,
    String? authorName,
    String? authorHandle,
    String? content,
    String? timestamp,
    int? likes,
    bool? isAuthor,
    bool? isSaved,
  }) {
    return CircleComment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      authorName: authorName ?? this.authorName,
      authorHandle: authorHandle ?? this.authorHandle,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      isAuthor: isAuthor ?? this.isAuthor,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}

/// Community / Subject Guild model.
class CircleCommunity {
  final String id;
  final String name;
  final String description;
  final String category;
  final String bannerUrl;
  final int memberCount;
  final bool isJoined;
  final bool notificationsEnabled;

  const CircleCommunity({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    this.bannerUrl = '',
    this.memberCount = 0,
    this.isJoined = false,
    this.notificationsEnabled = true,
  });

  factory CircleCommunity.fromJson(Map<String, dynamic> json) {
    return CircleCommunity(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? 'General',
      bannerUrl: json['bannerUrl']?.toString() ?? json['banner_url']?.toString() ?? '',
      memberCount: (json['memberCount'] ?? json['member_count'] ?? 0) as int,
      isJoined: json['isJoined'] == true || json['is_joined'] == 1,
      notificationsEnabled: json['notificationsEnabled'] ?? json['notifications_enabled'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'bannerUrl': bannerUrl,
      'memberCount': memberCount,
      'isJoined': isJoined,
      'notificationsEnabled': notificationsEnabled,
    };
  }

  CircleCommunity copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? bannerUrl,
    int? memberCount,
    bool? isJoined,
    bool? notificationsEnabled,
  }) {
    return CircleCommunity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      memberCount: memberCount ?? this.memberCount,
      isJoined: isJoined ?? this.isJoined,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

/// Event model.
class CircleEvent {
  final String id;
  final String title;
  final String date;
  final String location;
  final String imageUrl;
  final int attendees;
  final bool isAttending;
  final String category;
  final String description;

  const CircleEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    this.imageUrl = '',
    this.attendees = 0,
    this.isAttending = false,
    this.category = 'Technology',
    this.description = '',
  });

  factory CircleEvent.fromJson(Map<String, dynamic> json) {
    return CircleEvent(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? json['image_url']?.toString() ?? '',
      attendees: (json['attendees'] ?? json['attendee_count'] ?? 0) as int,
      isAttending: json['isAttending'] == true || json['is_attending'] == 1,
      category: json['category']?.toString() ?? 'Technology',
      description: json['description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'location': location,
      'imageUrl': imageUrl,
      'attendees': attendees,
      'isAttending': isAttending,
      'category': category,
      'description': description,
    };
  }

  CircleEvent copyWith({
    String? id,
    String? title,
    String? date,
    String? location,
    String? imageUrl,
    int? attendees,
    bool? isAttending,
    String? category,
    String? description,
  }) {
    return CircleEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      attendees: attendees ?? this.attendees,
      isAttending: isAttending ?? this.isAttending,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }
}

/// Direct message conversation preview model.
class CircleMessage {
  final String id;
  final String senderName;
  final String handle;
  final String avatarUrl;
  final String preview;
  final String time;
  final int unread;
  final bool isOnline;
  final bool isMuted;
  final bool isArchived;

  const CircleMessage({
    required this.id,
    required this.senderName,
    required this.handle,
    this.avatarUrl = '',
    required this.preview,
    required this.time,
    this.unread = 0,
    this.isOnline = false,
    this.isMuted = false,
    this.isArchived = false,
  });

  factory CircleMessage.fromJson(Map<String, dynamic> json) {
    return CircleMessage(
      id: json['id']?.toString() ?? '',
      senderName: json['senderName']?.toString() ?? json['sender_name']?.toString() ?? '',
      handle: json['handle']?.toString() ?? '',
      avatarUrl: json['avatarUrl']?.toString() ?? json['avatar_url']?.toString() ?? '',
      preview: json['preview']?.toString() ?? json['content']?.toString() ?? '',
      time: json['time']?.toString() ?? json['created_at']?.toString() ?? '',
      unread: (json['unread'] ?? json['unread_count'] ?? 0) as int,
      isOnline: json['isOnline'] == true || json['is_online'] == 1,
      isMuted: json['isMuted'] == true || json['is_muted'] == 1,
      isArchived: json['isArchived'] == true || json['is_archived'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderName': senderName,
      'handle': handle,
      'avatarUrl': avatarUrl,
      'preview': preview,
      'time': time,
      'unread': unread,
      'isOnline': isOnline,
      'isMuted': isMuted,
      'isArchived': isArchived,
    };
  }

  CircleMessage copyWith({
    String? id,
    String? senderName,
    String? handle,
    String? avatarUrl,
    String? preview,
    String? time,
    int? unread,
    bool? isOnline,
    bool? isMuted,
    bool? isArchived,
  }) {
    return CircleMessage(
      id: id ?? this.id,
      senderName: senderName ?? this.senderName,
      handle: handle ?? this.handle,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      preview: preview ?? this.preview,
      time: time ?? this.time,
      unread: unread ?? this.unread,
      isOnline: isOnline ?? this.isOnline,
      isMuted: isMuted ?? this.isMuted,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}

/// Notification model.
class CircleNotification {
  final String id;
  final String title;
  final String detail;
  final String time;
  final bool isUnread;
  final String category;

  const CircleNotification({
    required this.id,
    required this.title,
    required this.detail,
    required this.time,
    this.isUnread = true,
    this.category = 'social',
  });

  factory CircleNotification.fromJson(Map<String, dynamic> json) {
    return CircleNotification(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      detail: json['detail']?.toString() ?? json['message']?.toString() ?? '',
      time: json['time']?.toString() ?? json['created_at']?.toString() ?? '',
      isUnread: json['isUnread'] ?? json['is_unread'] ?? true,
      category: json['category']?.toString() ?? 'social',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
      'time': time,
      'isUnread': isUnread,
      'category': category,
    };
  }

  CircleNotification copyWith({
    String? id,
    String? title,
    String? detail,
    String? time,
    bool? isUnread,
    String? category,
  }) {
    return CircleNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      time: time ?? this.time,
      isUnread: isUnread ?? this.isUnread,
      category: category ?? this.category,
    );
  }
}

/// Friend / Connection Model
class CircleFriend {
  final String id;
  final String userId;
  final String friendId;
  final String friendName;
  final String friendHandle;
  final String friendAvatarUrl;
  final String status; // 'connected', 'pending', 'blocked'
  final String connectedSince;

  const CircleFriend({
    required this.id,
    required this.userId,
    required this.friendId,
    required this.friendName,
    required this.friendHandle,
    this.friendAvatarUrl = '',
    this.status = 'connected',
    this.connectedSince = '',
  });

  factory CircleFriend.fromJson(Map<String, dynamic> json) {
    return CircleFriend(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? json['user_id']?.toString() ?? '',
      friendId: json['friendId']?.toString() ?? json['friend_id']?.toString() ?? '',
      friendName: json['friendName']?.toString() ?? json['friend_name']?.toString() ?? '',
      friendHandle: json['friendHandle']?.toString() ?? json['friend_handle']?.toString() ?? '',
      friendAvatarUrl: json['friendAvatarUrl']?.toString() ?? json['friend_avatar_url']?.toString() ?? '',
      status: json['status']?.toString() ?? 'connected',
      connectedSince: json['connectedSince']?.toString() ?? json['connected_since']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'friendId': friendId,
      'friendName': friendName,
      'friendHandle': friendHandle,
      'friendAvatarUrl': friendAvatarUrl,
      'status': status,
      'connectedSince': connectedSince,
    };
  }
}

/// Friend Request Model
class CircleFriendRequest {
  final String id;
  final String senderId;
  final String senderName;
  final String senderHandle;
  final String senderAvatarUrl;
  final String sentAt;

  const CircleFriendRequest({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderHandle,
    this.senderAvatarUrl = '',
    required this.sentAt,
  });

  factory CircleFriendRequest.fromJson(Map<String, dynamic> json) {
    return CircleFriendRequest(
      id: json['id']?.toString() ?? '',
      senderId: json['senderId']?.toString() ?? json['sender_id']?.toString() ?? '',
      senderName: json['senderName']?.toString() ?? json['sender_name']?.toString() ?? '',
      senderHandle: json['senderHandle']?.toString() ?? json['sender_handle']?.toString() ?? '',
      senderAvatarUrl: json['senderAvatarUrl']?.toString() ?? json['sender_avatar_url']?.toString() ?? '',
      sentAt: json['sentAt']?.toString() ?? json['created_at']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'senderHandle': senderHandle,
      'senderAvatarUrl': senderAvatarUrl,
      'sentAt': sentAt,
    };
  }
}

/// Story Model
class CircleStory {
  final String id;
  final String authorId;
  final String authorName;
  final String authorAvatarUrl;
  final String mediaUrl;
  final String createdAt;
  final bool isViewed;

  const CircleStory({
    required this.id,
    required this.authorId,
    required this.authorName,
    this.authorAvatarUrl = '',
    required this.mediaUrl,
    required this.createdAt,
    this.isViewed = false,
  });

  factory CircleStory.fromJson(Map<String, dynamic> json) {
    return CircleStory(
      id: json['id']?.toString() ?? '',
      authorId: json['authorId']?.toString() ?? json['author_id']?.toString() ?? '',
      authorName: json['authorName']?.toString() ?? json['author_name']?.toString() ?? '',
      authorAvatarUrl: json['authorAvatarUrl']?.toString() ?? json['author_avatar_url']?.toString() ?? '',
      mediaUrl: json['mediaUrl']?.toString() ?? json['media_url']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? json['created_at']?.toString() ?? '',
      isViewed: json['isViewed'] == true || json['is_viewed'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorId': authorId,
      'authorName': authorName,
      'authorAvatarUrl': authorAvatarUrl,
      'mediaUrl': mediaUrl,
      'createdAt': createdAt,
      'isViewed': isViewed,
    };
  }
}

/// Saved Item Model
class CircleSavedItem {
  final String id;
  final String userId;
  final String itemId;
  final String itemType; // 'post', 'article', 'event'
  final String savedAt;
  final CirclePost? post;

  const CircleSavedItem({
    required this.id,
    required this.userId,
    required this.itemId,
    required this.itemType,
    required this.savedAt,
    this.post,
  });

  factory CircleSavedItem.fromJson(Map<String, dynamic> json) {
    return CircleSavedItem(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? json['user_id']?.toString() ?? '',
      itemId: json['itemId']?.toString() ?? json['item_id']?.toString() ?? '',
      itemType: json['itemType']?.toString() ?? json['item_type']?.toString() ?? 'post',
      savedAt: json['savedAt']?.toString() ?? json['created_at']?.toString() ?? '',
      post: json['post'] != null ? CirclePost.fromJson(json['post'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'itemId': itemId,
      'itemType': itemType,
      'savedAt': savedAt,
      'post': post?.toJson(),
    };
  }
}

/// Privacy Settings Model
class PrivacySettings {
  final String profileVisibility;
  final String postVisibility;
  final String messagingPrivacy;
  final bool allowFriendRequests;
  final bool dataTelemetry;
  final List<String> blockedUserIds;
  final List<String> restrictedUserIds;

  const PrivacySettings({
    this.profileVisibility = 'Circles Only',
    this.postVisibility = 'Circles Only',
    this.messagingPrivacy = 'Circles & Mutual Connections',
    this.allowFriendRequests = true,
    this.dataTelemetry = false,
    this.blockedUserIds = const [],
    this.restrictedUserIds = const [],
  });

  factory PrivacySettings.fromJson(Map<String, dynamic> json) {
    return PrivacySettings(
      profileVisibility: json['profileVisibility']?.toString() ?? json['profile_visibility']?.toString() ?? 'Circles Only',
      postVisibility: json['postVisibility']?.toString() ?? json['post_visibility']?.toString() ?? 'Circles Only',
      messagingPrivacy: json['messagingPrivacy']?.toString() ?? json['messaging_privacy']?.toString() ?? 'Circles & Mutual Connections',
      allowFriendRequests: json['allowFriendRequests'] ?? json['allow_friend_requests'] ?? true,
      dataTelemetry: json['dataTelemetry'] ?? json['data_telemetry'] ?? false,
      blockedUserIds: (json['blockedUserIds'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
      restrictedUserIds: (json['restrictedUserIds'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profileVisibility': profileVisibility,
      'postVisibility': postVisibility,
      'messagingPrivacy': messagingPrivacy,
      'allowFriendRequests': allowFriendRequests,
      'dataTelemetry': dataTelemetry,
      'blockedUserIds': blockedUserIds,
      'restrictedUserIds': restrictedUserIds,
    };
  }
}

/// Watch Video Item
class CircleWatchItem {
  final String id;
  final String title;
  final String creatorName;
  final String duration;
  final String views;
  final String timeAgo;
  final String category;
  final String description;

  const CircleWatchItem({
    required this.id,
    required this.title,
    required this.creatorName,
    required this.duration,
    this.views = '0',
    required this.timeAgo,
    required this.category,
    required this.description,
  });

  factory CircleWatchItem.fromJson(Map<String, dynamic> json) {
    return CircleWatchItem(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      creatorName: json['creatorName']?.toString() ?? json['creator_name']?.toString() ?? '',
      duration: json['duration']?.toString() ?? '',
      views: json['views']?.toString() ?? '0',
      timeAgo: json['timeAgo']?.toString() ?? json['time_ago']?.toString() ?? '',
      category: json['category']?.toString() ?? 'General',
      description: json['description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'creatorName': creatorName,
      'duration': duration,
      'views': views,
      'timeAgo': timeAgo,
      'category': category,
      'description': description,
    };
  }
}

/// Marketplace Item
class CircleMarketItem {
  final String id;
  final String title;
  final String price;
  final String seller;
  final String location;
  final String category;
  final String condition;

  const CircleMarketItem({
    required this.id,
    required this.title,
    required this.price,
    required this.seller,
    required this.location,
    required this.category,
    required this.condition,
  });

  factory CircleMarketItem.fromJson(Map<String, dynamic> json) {
    return CircleMarketItem(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      seller: json['seller']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      category: json['category']?.toString() ?? 'General',
      condition: json['condition']?.toString() ?? 'Good',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'seller': seller,
      'location': location,
      'category': category,
      'condition': condition,
    };
  }
}

/// Memory Item
class CircleMemory {
  final String id;
  final String title;
  final String dateAgo;
  final String snippet;
  final CirclePost originalPost;

  const CircleMemory({
    required this.id,
    required this.title,
    required this.dateAgo,
    required this.snippet,
    required this.originalPost,
  });

  factory CircleMemory.fromJson(Map<String, dynamic> json) {
    return CircleMemory(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      dateAgo: json['dateAgo']?.toString() ?? json['date_ago']?.toString() ?? '',
      snippet: json['snippet']?.toString() ?? '',
      originalPost: CirclePost.fromJson(json['originalPost'] as Map<String, dynamic>? ?? json['original_post'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'dateAgo': dateAgo,
      'snippet': snippet,
      'originalPost': originalPost.toJson(),
    };
  }
}

/// Active Session Device
class SessionDevice {
  final String id;
  final String name;
  final String platform;
  final String location;
  final String lastActive;
  final bool isCurrent;

  const SessionDevice({
    required this.id,
    required this.name,
    required this.platform,
    required this.location,
    required this.lastActive,
    this.isCurrent = false,
  });

  factory SessionDevice.fromJson(Map<String, dynamic> json) {
    return SessionDevice(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      platform: json['platform']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      lastActive: json['lastActive']?.toString() ?? json['last_active']?.toString() ?? '',
      isCurrent: json['isCurrent'] == true || json['is_current'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'platform': platform,
      'location': location,
      'lastActive': lastActive,
      'isCurrent': isCurrent,
    };
  }
}

/// Static app settings item (UI navigation item)
class AppSetting {
  final String title;
  final String subtitle;
  final IconData icon;

  const AppSetting({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

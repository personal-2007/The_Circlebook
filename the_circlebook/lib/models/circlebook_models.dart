import 'package:flutter/material.dart';

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
    required this.avatarUrl,
    required this.headline,
    required this.location,
    required this.about,
    required this.role,
    required this.college,
    required this.skills,
    required this.interests,
    required this.circleCount,
    this.followerCount = 1420,
    this.postCount = 84,
    this.isConnected = false,
    this.isBlocked = false,
    this.isRestricted = false,
  });

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
    required this.authorAvatarUrl,
    required this.timestamp,
    required this.content,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.tags,
    required this.isLiked,
    this.isSaved = false,
    this.isNotificationsOn = true,
    this.algorithmReason,
  });

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
    required this.bannerUrl,
    required this.memberCount,
    required this.isJoined,
    this.notificationsEnabled = true,
  });

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
    required this.imageUrl,
    required this.attendees,
    this.isAttending = false,
    this.category = 'Technology',
    this.description = 'Join fellow circle members for deep collaborative sessions.',
  });

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
    required this.avatarUrl,
    required this.preview,
    required this.time,
    required this.unread,
    required this.isOnline,
    this.isMuted = false,
    this.isArchived = false,
  });

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
    required this.isUnread,
    this.category = 'social',
  });

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
    required this.views,
    required this.timeAgo,
    required this.category,
    required this.description,
  });
}

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
}

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
}

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
}

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

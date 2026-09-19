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
  });
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
  });
}

class CircleCommunity {
  final String id;
  final String name;
  final String description;
  final String category;
  final String bannerUrl;
  final int memberCount;
  final bool isJoined;

  const CircleCommunity({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.bannerUrl,
    required this.memberCount,
    required this.isJoined,
  });
}

class CircleEvent {
  final String id;
  final String title;
  final String date;
  final String location;
  final String imageUrl;
  final int attendees;

  const CircleEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.attendees,
  });
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

  const CircleMessage({
    required this.id,
    required this.senderName,
    required this.handle,
    required this.avatarUrl,
    required this.preview,
    required this.time,
    required this.unread,
    required this.isOnline,
  });
}

class CircleNotification {
  final String id;
  final String title;
  final String detail;
  final String time;
  final bool isUnread;

  const CircleNotification({
    required this.id,
    required this.title,
    required this.detail,
    required this.time,
    required this.isUnread,
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


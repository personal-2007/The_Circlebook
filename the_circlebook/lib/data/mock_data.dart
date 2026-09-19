import 'package:flutter/material.dart';

import '../models/circlebook_models.dart';

class MockData {
  static const CircleUser currentUser = CircleUser(
    id: 'usr_001',
    name: 'Aarav Sharma',
    handle: '@aarav_sharma',
    avatarUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=250&q=80',
    headline: 'Senior Frontend Engineer & Open Source Advocate',
    location: 'Bengaluru, India',
    about:
        'Passionate about web performance, vintage design systems, and building collaborative communities.',
    role: 'member',
    college: 'IIT Bombay • Computer Science (2021)',
    skills: ['JavaScript', 'React', 'CSS Architecture', 'TypeScript'],
    interests: ['Retro Computing', 'Design Systems', 'Coffee Brewing'],
    circleCount: 42,
  );

  static const List<CircleUser> suggestedPeople = [
    CircleUser(
      id: 'usr_002',
      name: 'Priya Nair',
      handle: '@priya_nair',
      avatarUrl:
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=250&q=80',
      headline: 'Product Designer & Visual Strategist',
      location: 'Mumbai, India',
      about: 'Designing thoughtful digital experiences with nostalgia and crisp typography.',
      role: 'member',
      college: 'NID Ahmedabad • Industrial Design',
      skills: ['UI/UX Design', 'Figma', 'Design Systems'],
      interests: ['Typography', 'Print Media', 'Photography'],
      circleCount: 88,
    ),
    CircleUser(
      id: 'usr_003',
      name: 'Rohan Varma',
      handle: '@rohan_v',
      avatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=250&q=80',
      headline: 'AI Engineer & Machine Learning Specialist',
      location: 'Hyderabad, India',
      about: 'Building next-generation generative AI assistants and recommendation algorithms.',
      role: 'member',
      college: 'IIIT Hyderabad • AI',
      skills: ['Python', 'PyTorch', 'LLMs', 'NLP'],
      interests: ['Artificial Intelligence', 'Chess'],
      circleCount: 120,
    ),
    CircleUser(
      id: 'usr_004',
      name: 'Ananya Roy',
      handle: '@ananya_roy',
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=250&q=80',
      headline: 'Community Lead & Tech Organizer',
      location: 'Bengaluru, India',
      about: 'Managing community safety, global outreach, and circle events.',
      role: 'admin',
      college: 'St. Xavier\'s Kolkata • Mass Comm',
      skills: ['Community Management', 'Event Planning'],
      interests: ['Networking', 'Podcasting', 'Literature'],
      circleCount: 310,
    ),
  ];

  static const List<CirclePost> posts = [
    CirclePost(
      id: 'post_101',
      authorId: 'usr_004',
      authorName: 'Ananya Roy',
      authorHandle: '@ananya_roy',
      authorAvatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=250&q=80',
      timestamp: '2 hours ago',
      content:
          'The Circlebook community is feeling fresh and familiar this week. Clean cards, strong conversations, and better ways to keep up with friends and groups. What would you like to see next in the feed?',
      likes: 42,
      comments: 12,
      shares: 9,
      tags: ['#Circlebook', '#Community', '#Update'],
      isLiked: true,
    ),
    CirclePost(
      id: 'post_102',
      authorId: 'usr_002',
      authorName: 'Priya Nair',
      authorHandle: '@priya_nair',
      authorAvatarUrl:
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=250&q=80',
      timestamp: '5 hours ago',
      content:
          'Exploring vintage newspaper layouts from the 1950s to create clean, human-first digital interfaces. Minimal noise, rich typography, and meaningful connections.',
      imageUrl: 'https://images.unsplash.com/photo-1507679799987-c73779587ccf?auto=format&fit=crop&w=800&q=80',
      likes: 29,
      comments: 6,
      shares: 5,
      tags: ['#DesignSystems', '#Typography', '#VintageUI'],
      isLiked: false,
    ),
    CirclePost(
      id: 'post_103',
      authorId: 'usr_003',
      authorName: 'Rohan Varma',
      authorHandle: '@rohan_v',
      authorAvatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=250&q=80',
      timestamp: '1 day ago',
      content:
          'Just published a benchmark comparing lightweight local embedding models for community directory searches. Semantic vector match yields 40% better connection suggestions than pure keyword match.',
      likes: 56,
      comments: 15,
      shares: 18,
      tags: ['#AI', '#MachineLearning', '#VectorSearch'],
      isLiked: false,
    ),
  ];

  static const List<CircleCommunity> communities = [
    CircleCommunity(
      id: 'comm_1',
      name: 'Frontend Guild & UI Design',
      description: 'A community for web developers, CSS craftsmen, and design systems enthusiasts.',
      category: 'Technology',
      bannerUrl: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=800&q=80',
      memberCount: 1420,
      isJoined: true,
    ),
    CircleCommunity(
      id: 'comm_2',
      name: 'Vintage Typography & Print Society',
      description: 'Celebrating mid-century editorial design, woodblock printing, serif fonts, and classical typesetting.',
      category: 'Design',
      bannerUrl: 'https://images.unsplash.com/photo-1516962215378-7fa2e137ae93?auto=format&fit=crop&w=800&q=80',
      memberCount: 890,
      isJoined: false,
    ),
    CircleCommunity(
      id: 'comm_3',
      name: 'AI & Machine Learning Innovators',
      description: 'Building open source LLM tools, agentic assistants, and vector embeddings.',
      category: 'Artificial Intelligence',
      bannerUrl: 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?auto=format&fit=crop&w=800&q=80',
      memberCount: 2310,
      isJoined: true,
    ),
  ];

  static const List<CircleEvent> events = [
    CircleEvent(
      id: 'evt_1',
      title: 'Designing for Clarity',
      date: 'Sat, 6:00 PM',
      location: 'Bengaluru Design Hub',
      imageUrl: 'https://images.unsplash.com/photo-1511578314322-379afb476865?auto=format&fit=crop&w=800&q=80',
      attendees: 248,
    ),
    CircleEvent(
      id: 'evt_2',
      title: 'Open Source Night',
      date: 'Wed, 7:30 PM',
      location: 'Virtual Meetup',
      imageUrl: 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=800&q=80',
      attendees: 164,
    ),
  ];

  static const List<CircleMessage> messages = [
    CircleMessage(
      id: 'msg_1',
      senderName: 'Priya Nair',
      handle: '@priya_nair',
      avatarUrl:
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=250&q=80',
      preview: 'The new feed concept feels much calmer and easier to browse.',
      time: '2m ago',
      unread: 2,
      isOnline: true,
    ),
    CircleMessage(
      id: 'msg_2',
      senderName: 'Rohan Varma',
      handle: '@rohan_v',
      avatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=250&q=80',
      preview: 'The vector search benchmark is looking strong on the first pass.',
      time: '1h ago',
      unread: 1,
      isOnline: false,
    ),
    CircleMessage(
      id: 'msg_3',
      senderName: 'Ananya Roy',
      handle: '@ananya_roy',
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=250&q=80',
      preview: 'Could you share feedback on the groups experience before launch?',
      time: 'Yesterday',
      unread: 0,
      isOnline: true,
    ),
  ];

  static const List<CircleNotification> notifications = [
    CircleNotification(
      id: 'n_1',
      title: 'New connection request',
      detail: 'Vikram Sengupta wants to connect with you.',
      time: '12 min ago',
      isUnread: true,
    ),
    CircleNotification(
      id: 'n_2',
      title: 'Community update',
      detail: 'Frontend Guild has a new discussion about CSS grid patterns.',
      time: '1 hour ago',
      isUnread: true,
    ),
    CircleNotification(
      id: 'n_3',
      title: 'Event reminder',
      detail: 'Open Source Night starts in 2 hours.',
      time: 'Today',
      isUnread: false,
    ),
  ];

  static const List<AppSetting> settings = [
    AppSetting(
      title: 'Appearance',
      subtitle: 'Theme, compact mode, font size',
      icon: Icons.palette_outlined,
    ),
    AppSetting(
      title: 'Privacy & Security',
      subtitle: 'Visibility and account controls',
      icon: Icons.shield_outlined,
    ),
    AppSetting(
      title: 'Notifications',
      subtitle: 'Manage your alerts and updates',
      icon: Icons.notifications_none_outlined,
    ),
    AppSetting(
      title: 'Help & Support',
      subtitle: 'View resources and report an issue',
      icon: Icons.help_outline,
    ),
  ];
}

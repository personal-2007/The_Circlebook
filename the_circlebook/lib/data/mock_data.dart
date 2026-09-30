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
    skills: ['JavaScript', 'React', 'CSS Architecture', 'TypeScript', 'Flutter'],
    interests: ['Retro Computing', 'Design Systems', 'Coffee Brewing', 'Privacy Tech'],
    circleCount: 42,
    followerCount: 4800,
    postCount: 128,
    isConnected: true,
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
      followerCount: 3200,
      postCount: 76,
      isConnected: false,
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
      followerCount: 5400,
      postCount: 92,
      isConnected: true,
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
      followerCount: 9100,
      postCount: 184,
      isConnected: true,
    ),
    CircleUser(
      id: 'usr_005',
      name: 'Vikram Sengupta',
      handle: '@vikram_s',
      avatarUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=250&q=80',
      headline: 'Systems Architect & Cloud Strategist',
      location: 'Pune, India',
      about: 'Distributed computing, reliable microservices, and cross-platform continuity.',
      role: 'member',
      college: 'BITS Pilani • Electronics',
      skills: ['Kubernetes', 'Go', 'Distributed Systems'],
      interests: ['Distributed Tech', 'Cycling', 'Astronomy'],
      circleCount: 65,
      followerCount: 2100,
      postCount: 45,
      isConnected: false,
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
      algorithmReason: 'Shared by members in your primary circle',
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
      algorithmReason: 'Popular in Design Systems & Typography',
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
      algorithmReason: 'Matches your interest in Engineering & AI',
    ),
  ];

  static const List<CircleComment> mockComments = [
    CircleComment(
      id: 'c_1',
      postId: 'post_101',
      authorName: 'Priya Nair',
      authorHandle: '@priya_nair',
      content: 'I really love how calm the interface feels. No blinking distractions!',
      timestamp: '1 hour ago',
      likes: 5,
    ),
    CircleComment(
      id: 'c_2',
      postId: 'post_101',
      authorName: 'Aarav Sharma',
      authorHandle: '@aarav_sharma',
      content: 'The user-controlled algorithm sorting is what makes it stand out for me.',
      timestamp: '45m ago',
      likes: 8,
      isAuthor: true,
    ),
    CircleComment(
      id: 'c_3',
      postId: 'post_102',
      authorName: 'Vikram Sengupta',
      authorHandle: '@vikram_s',
      content: 'High contrast and generous whitespace makes a huge readability difference.',
      timestamp: '3 hours ago',
      likes: 3,
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
    CircleCommunity(
      id: 'comm_4',
      name: 'Clean Code & Architecture Guild',
      description: 'Discussions on modular system design, domain-driven design, and maintainable software practices.',
      category: 'Engineering',
      bannerUrl: 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?auto=format&fit=crop&w=800&q=80',
      memberCount: 3120,
      isJoined: false,
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
      isAttending: true,
      category: 'Design & UX',
      description: 'An interactive seminar breaking down classical information hierarchy in modern apps.',
    ),
    CircleEvent(
      id: 'evt_2',
      title: 'Open Source Night',
      date: 'Wed, 7:30 PM',
      location: 'Virtual Meetup',
      imageUrl: 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=800&q=80',
      attendees: 164,
      isAttending: false,
      category: 'Open Source',
      description: 'Collaborate live on public good repositories and privacy-respecting platforms.',
    ),
    CircleEvent(
      id: 'evt_3',
      title: 'Global Social Networks 2030 Summit',
      date: 'Nov 14, 10:00 AM',
      location: 'Hybrid • Global',
      imageUrl: 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?auto=format&fit=crop&w=800&q=80',
      attendees: 512,
      isAttending: true,
      category: 'Future of Tech',
      description: 'Keynotes on decentralized identity, user-owned algorithms, and data sovereignty.',
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
    CircleMessage(
      id: 'msg_4',
      senderName: 'Vikram Sengupta',
      handle: '@vikram_s',
      avatarUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=250&q=80',
      preview: 'Let me know if you would like me to review the security sessions setup.',
      time: '3d ago',
      unread: 0,
      isOnline: false,
    ),
  ];

  static const List<CircleNotification> notifications = [
    CircleNotification(
      id: 'n_1',
      title: 'New connection request',
      detail: 'Vikram Sengupta wants to connect with you.',
      time: '12 min ago',
      isUnread: true,
      category: 'connection',
    ),
    CircleNotification(
      id: 'n_2',
      title: 'Community update',
      detail: 'Frontend Guild has a new discussion about CSS grid patterns.',
      time: '1 hour ago',
      isUnread: true,
      category: 'community',
    ),
    CircleNotification(
      id: 'n_3',
      title: 'Event reminder',
      detail: 'Open Source Night starts in 2 hours.',
      time: 'Today',
      isUnread: false,
      category: 'event',
    ),
    CircleNotification(
      id: 'n_4',
      title: 'Privacy alert',
      detail: 'New login session registered on Pixel Fold (Bengaluru).',
      time: '2 days ago',
      isUnread: false,
      category: 'security',
    ),
  ];

  static const List<CircleWatchItem> watchItems = [
    CircleWatchItem(
      id: 'w_1',
      title: 'Architecting Long-Lived Client State in Flutter',
      creatorName: 'Aarav Sharma',
      duration: '18:42',
      views: '4.2K',
      timeAgo: '3 days ago',
      category: 'Engineering',
      description: 'A walkthrough on reducing memory footprint and isolating reactive streams in large apps.',
    ),
    CircleWatchItem(
      id: 'w_2',
      title: 'The Return to Editorial Typographic Systems',
      creatorName: 'Priya Nair',
      duration: '12:15',
      views: '8.9K',
      timeAgo: '1 week ago',
      category: 'Design',
      description: 'Why 2030 digital products are returning to classical book and newspaper proportions.',
    ),
    CircleWatchItem(
      id: 'w_3',
      title: 'Explainable AI for Feed Transparency',
      creatorName: 'Rohan Varma',
      duration: '24:05',
      views: '11.4K',
      timeAgo: '2 weeks ago',
      category: 'Intelligence',
      description: 'Giving users real sliders and controls over their ranking weights and content filters.',
    ),
  ];

  static const List<CircleMarketItem> marketItems = [
    CircleMarketItem(
      id: 'm_1',
      title: 'Mechanical Keyboard (Custom 65% Tactile)',
      price: '\$140',
      seller: 'Priya Nair',
      location: 'Mumbai',
      category: 'Hardware',
      condition: 'Like New',
    ),
    CircleMarketItem(
      id: 'm_2',
      title: 'The Elements of Typographic Style (Hardcover)',
      price: '\$35',
      seller: 'Design Guild Archive',
      location: 'Bengaluru',
      category: 'Books',
      condition: 'Mint',
    ),
    CircleMarketItem(
      id: 'm_3',
      title: 'Dell UltraSharp 27" 4K Monitor',
      price: '\$280',
      seller: 'Rohan Varma',
      location: 'Hyderabad',
      category: 'Electronics',
      condition: 'Excellent',
    ),
  ];

  static final List<CircleMemory> memories = [
    CircleMemory(
      id: 'mem_1',
      title: '1 Year Ago Today',
      dateAgo: 'September 2025',
      snippet: 'Launched the first design systems guild at IIT Bombay.',
      originalPost: posts[1],
    ),
    CircleMemory(
      id: 'mem_2',
      title: '2 Years Ago Today',
      dateAgo: 'September 2024',
      snippet: 'First contribution merged to open source vector search indexing.',
      originalPost: posts[2],
    ),
  ];

  static const List<SessionDevice> activeSessions = [
    SessionDevice(
      id: 'dev_1',
      name: 'Android Phone (Pixel 8)',
      platform: 'Android 14',
      location: 'Bengaluru, India',
      lastActive: 'Active now',
      isCurrent: true,
    ),
    SessionDevice(
      id: 'dev_2',
      name: 'ThinkPad X1 Carbon',
      platform: 'Linux / Chrome 128',
      location: 'Bengaluru, India',
      lastActive: '3 hours ago',
      isCurrent: false,
    ),
    SessionDevice(
      id: 'dev_3',
      name: 'iPad Pro 11"',
      platform: 'iPadOS 18',
      location: 'Mumbai, India',
      lastActive: '2 days ago',
      isCurrent: false,
    ),
  ];

  static const List<AppSetting> settings = [
    AppSetting(
      title: 'Appearance',
      subtitle: 'Theme, compact mode, font size, high contrast',
      icon: Icons.palette_outlined,
    ),
    AppSetting(
      title: 'Privacy & Security',
      subtitle: 'Visibility, data permissions, and two-factor auth',
      icon: Icons.shield_outlined,
    ),
    AppSetting(
      title: 'Notifications',
      subtitle: 'Manage your alerts, push, and digest updates',
      icon: Icons.notifications_none_outlined,
    ),
    AppSetting(
      title: 'Personalization & Feed',
      subtitle: 'Algorithm preferences and content controls',
      icon: Icons.tune_rounded,
    ),
    AppSetting(
      title: 'Help & Support',
      subtitle: 'View resources, guidelines, and report an issue',
      icon: Icons.help_outline,
    ),
  ];
}

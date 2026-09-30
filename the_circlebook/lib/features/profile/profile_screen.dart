import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/circlebook_models.dart';
import '../../theme/app_theme.dart';
import '../shell/widgets/profile_menu_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CircleUser _user = MockData.currentUser;

  void _handleProfileMenuAction(String action) {
    switch (action) {
      case 'share':
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Share Profile'),
            content: Text('Share ${_user.name}\'s profile link:\nhttps://circlebook.org/${_user.handle.replaceAll('@', '')}'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
              FilledButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile link copied.')),
                  );
                },
                child: const Text('Copy Link'),
              ),
            ],
          ),
        );
        break;
      case 'restrict':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account privacy restrictions updated.')),
        );
        break;
      case 'block':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Blocking settings available in Privacy settings.')),
        );
        break;
      case 'report':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account report dialog opened.')),
        );
        break;
    }
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: _user.name);
    final headlineController = TextEditingController(text: _user.headline);
    final aboutController = TextEditingController(text: _user.about);
    final locationController = TextEditingController(text: _user.location);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(ctx),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: headlineController,
              decoration: const InputDecoration(labelText: 'Headline'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: aboutController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'About'),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                setState(() {
                  _user = _user.copyWith(
                    name: nameController.text.trim(),
                    headline: headlineController.text.trim(),
                    location: locationController.text.trim(),
                    about: aboutController.text.trim(),
                  );
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile updated successfully.')),
                );
              },
              child: const Text('Save Changes'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        // Profile Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                // Top row with account actions and contextual 3-dot menu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.account_circle_outlined),
                      tooltip: 'Account Menu',
                      onPressed: () => ProfileMenuSheet.show(
                        context,
                        onEditProfile: _showEditProfileDialog,
                      ),
                    ),
                    // Contextual 3-dot menu on Profile: Share, Block, Restrict, Report
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert_rounded),
                      tooltip: 'Profile options',
                      onSelected: _handleProfileMenuAction,
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 'share',
                          child: Row(
                            children: [
                              Icon(Icons.share_outlined, size: 18),
                              SizedBox(width: 10),
                              Text('Share Profile'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'restrict',
                          child: Row(
                            children: [
                              Icon(Icons.shield_outlined, size: 18),
                              SizedBox(width: 10),
                              Text('Restrict'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'block',
                          child: Row(
                            children: [
                              Icon(Icons.block_rounded, size: 18, color: AppTheme.danger),
                              SizedBox(width: 10),
                              Text('Block', style: TextStyle(color: AppTheme.danger)),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'report',
                          child: Row(
                            children: [
                              Icon(Icons.flag_outlined, size: 18, color: AppTheme.danger),
                              SizedBox(width: 10),
                              Text('Report', style: TextStyle(color: AppTheme.danger)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 42,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text(
                    _user.name.split(' ').map((p) => p[0]).take(2).join(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _user.name,
                  style: theme.textTheme.headlineSmall?.copyWith(fontSize: 19),
                ),
                const SizedBox(height: 2),
                Text(
                  _user.handle,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _user.headline,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_outlined, size: 14, color: theme.textTheme.bodySmall?.color),
                    const SizedBox(width: 4),
                    Text(_user.location, style: theme.textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatColumn(label: 'Circles', value: '${_user.circleCount}'),
                    _StatColumn(label: 'Posts', value: '${_user.postCount}'),
                    _StatColumn(label: 'Followers', value: '${_user.followerCount}'),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.tonal(
                        onPressed: _showEditProfileDialog,
                        child: const Text('Edit Profile'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pushNamed('/app/settings'),
                      child: const Icon(Icons.settings_outlined, size: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // About section
        Text(
          'About',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              _user.about,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Background / Affiliation
        Text(
          'Affiliation',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: Icon(Icons.school_outlined, color: theme.colorScheme.primary),
            title: Text(_user.college, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5)),
            subtitle: Text('Role: ${_user.role.toUpperCase()}', style: theme.textTheme.bodySmall),
          ),
        ),
        const SizedBox(height: 16),

        // Skills
        Text(
          'Skills & Specializations',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _user.skills.map((skill) {
            return Chip(
              label: Text(skill, style: const TextStyle(fontSize: 12.5)),
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              side: BorderSide(color: theme.dividerColor),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Privacy & Account quick tile
        Card(
          child: ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy & Visibility Controls'),
            subtitle: const Text('Manage who can find and message you'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => Navigator.of(context).pushNamed('/app/settings/privacy'),
          ),
        ),
      ],
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../services/storage_service.dart';
import '../../theme/app_theme.dart';

class PersonalizationSettingsView extends StatefulWidget {
  const PersonalizationSettingsView({super.key});

  @override
  State<PersonalizationSettingsView> createState() => _PersonalizationSettingsViewState();
}

class _PersonalizationSettingsViewState extends State<PersonalizationSettingsView> {
  late String _defaultFeedAlgo;
  bool _prioritizeCircles = true;
  bool _showInterestsDiscovery = true;

  @override
  void initState() {
    super.initState();
    _defaultFeedAlgo = StorageService.loadFeedAlgorithm();
  }

  void _updateAlgo(String val) {
    setState(() => _defaultFeedAlgo = val);
    StorageService.saveFeedAlgorithm(val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data & Personalization')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User-Controlled Algorithm Preferences (Section 10)
          Text('Algorithm Preferences', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Default Feed Sorting', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  const Text('Choose how posts in your primary feed are ranked by default:'),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _defaultFeedAlgo,
                    decoration: const InputDecoration(labelText: 'Feed Sorting Mode'),
                    items: const [
                      DropdownMenuItem(value: 'for_you', child: Text('Relevant (Network-weighted recommendation)')),
                      DropdownMenuItem(value: 'following', child: Text('Chronological (Latest posts first)')),
                      DropdownMenuItem(value: 'circles', child: Text('Close Circles Only (Primary peers)')),
                    ],
                    onChanged: (val) => _updateAlgo(val!),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Prioritize Verified Connections'),
                    subtitle: const Text('Always place updates from direct circle peers at top of feed'),
                    value: _prioritizeCircles,
                    onChanged: (val) => setState(() => _prioritizeCircles = val),
                  ),
                  const Divider(),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Discovery & Opportunity Matching'),
                    subtitle: const Text('Suggest collaborative research and peers based on matching skills'),
                    value: _showInterestsDiscovery,
                    onChanged: (val) => setState(() => _showInterestsDiscovery = val),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Data Sovereignty & History (Section 11)
          Text('Data Sovereignty & History', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.download_rounded, color: AppTheme.primary),
                  title: const Text('Download Your Data (Data Export)'),
                  subtitle: const Text('Export all posts, circles, messages, and profile records (JSON / ZIP)'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Request Data Export'),
                        content: const Text('A comprehensive, portable archive of your Circlebook data will be generated. You will receive a verified download link via email within 24 hours.'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Data archive compilation requested.')),
                              );
                            },
                            child: const Text('Start Export'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.history_rounded, color: AppTheme.secondary),
                  title: const Text('Activity History'),
                  subtitle: const Text('View and clear logs of reactions, comments, and shares'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Activity history is accessible.')),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.manage_search_rounded, color: AppTheme.purple),
                  title: const Text('Search History'),
                  subtitle: const Text('Clear cached search queries and query suggestions'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Clear Search History?'),
                        content: const Text('This will delete all past search queries stored on this device.'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Search history cleared.')),
                              );
                            },
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

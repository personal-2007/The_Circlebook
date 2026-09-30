import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

/// Circle AI Workspace (under More -> Intelligence)
/// Clean, mature assistant interface for drafting, summarizing discussions, and exploring papers.
class CircleAIScreen extends StatefulWidget {
  const CircleAIScreen({super.key});

  @override
  State<CircleAIScreen> createState() => _CircleAIScreenState();
}

class _CircleAIScreenState extends State<CircleAIScreen> {
  final _inputController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      'role': 'assistant',
      'text': 'Welcome to Circle AI. I can help synthesize discussions across your circles, prepare structured paper summaries, or refine draft proposals. What would you like to explore today?',
    },
  ];
  bool _isProcessing = false;

  void _sendQuery() {
    final query = _inputController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': query});
      _inputController.clear();
      _isProcessing = true;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isProcessing = false;
          _messages.add({
            'role': 'assistant',
            'text': 'Summary of "$query": Analyzed recent discussions in Frontend Guild & Vintage Typography. Found strong consensus around classical typographic grids, responsive fluid layouts, and privacy-respecting recommendation algorithms.',
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.purple.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.auto_awesome_rounded, color: AppTheme.purple, size: 18),
            ),
            const SizedBox(width: 10),
            const Text('Circle AI Assistant'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final m = _messages[index];
                final isUser = m['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.82,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? AppTheme.primary : theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      m['text']!,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: isUser ? Colors.white : theme.textTheme.bodyLarge?.color,
                        height: 1.45,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isProcessing) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2)),
                  SizedBox(width: 10),
                  Text('Synthesizing circle insights...', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(top: BorderSide(color: theme.dividerColor)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      decoration: const InputDecoration(
                        hintText: 'Ask Circle AI to summarize or draft...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _sendQuery,
                    style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16)),
                    child: const Icon(Icons.arrow_upward_rounded, size: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Recommendations Transparency & Control Screen (under More -> Intelligence)
class RecommendationsControlScreen extends StatefulWidget {
  const RecommendationsControlScreen({super.key});

  @override
  State<RecommendationsControlScreen> createState() => _RecommendationsControlScreenState();
}

class _RecommendationsControlScreenState extends State<RecommendationsControlScreen> {
  double _recencyWeight = 0.7;
  double _circleAffinityWeight = 0.8;
  double _topicSimilarityWeight = 0.5;
  bool _showExplanations = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recommendations Transparency')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explainable Recommendations',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  const Text('Circlebook uses transparent ranking signals so you understand why content and people appear in your feed.'),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Show Algorithm Reasons on Posts'),
                    subtitle: const Text('Display explainability badges on recommended posts'),
                    value: _showExplanations,
                    onChanged: (val) => setState(() => _showExplanations = val),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tune Recommendation Signals',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 14),
                  Text('Recency Weight: ${(_recencyWeight * 100).toInt()}%'),
                  Slider(
                    value: _recencyWeight,
                    onChanged: (val) => setState(() => _recencyWeight = val),
                  ),
                  const SizedBox(height: 8),
                  Text('Circle Network Affinity: ${(_circleAffinityWeight * 100).toInt()}%'),
                  Slider(
                    value: _circleAffinityWeight,
                    onChanged: (val) => setState(() => _circleAffinityWeight = val),
                  ),
                  const SizedBox(height: 8),
                  Text('Topic & Skill Similarity: ${(_topicSimilarityWeight * 100).toInt()}%'),
                  Slider(
                    value: _topicSimilarityWeight,
                    onChanged: (val) => setState(() => _topicSimilarityWeight = val),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

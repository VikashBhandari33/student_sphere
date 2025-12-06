import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/notices/data/notice_repository.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shimmer/shimmer.dart';

final noticeSummaryProvider = FutureProvider<String>((ref) async {
  final repository = ref.watch(noticeRepositoryProvider);
  return repository.getSummarizedNotices();
});

class NoticeSegment extends ConsumerWidget {
  const NoticeSegment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(noticeSummaryProvider);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        title: Row(
          children: [
            Icon(Icons.announcement, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            const Text(
              'Daily Briefing',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        initiallyExpanded: true,
        childrenPadding: const EdgeInsets.all(16.0),
        children: [
          summaryAsync.when(
            data: (summary) => MarkdownBody(data: summary),
            loading: () => _buildLoadingState(),
            error: (error, stack) => Text(
              'Failed to load notices: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 16, width: double.infinity, color: Colors.white),
          const SizedBox(height: 8),
          Container(height: 16, width: double.infinity, color: Colors.white),
          const SizedBox(height: 8),
          Container(height: 16, width: 200, color: Colors.white),
        ],
      ),
    );
  }
}

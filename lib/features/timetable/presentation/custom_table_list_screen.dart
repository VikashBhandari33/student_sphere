import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_sphere/features/timetable/presentation/custom_table_controller.dart';

class CustomTableListScreen extends ConsumerWidget {
  const CustomTableListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableState = ref.watch(customTableControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Tables')),
      body: tableState.when(
        data: (tables) {
          if (tables.isEmpty) {
            return const Center(child: Text('No tables found. Create one!'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tables.length,
            itemBuilder: (context, index) {
              final table = tables[index];
              return Card(
                child: ListTile(
                  title: Text(table.title),
                  subtitle: Text('${table.rows.length} rows'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    context.go('/home/timetable/tables/${table.id}');
                  },
                  onLongPress: () {
                    // Delete option
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Table'),
                        content: const Text(
                            'Are you sure you want to delete this table?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(customTableControllerProvider.notifier)
                                  .deleteTable(table.id);
                              Navigator.pop(context);
                            },
                            child: const Text('Delete',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateTableDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateTableDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Table'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: 'Table Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                ref
                    .read(customTableControllerProvider.notifier)
                    .createTable(titleController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

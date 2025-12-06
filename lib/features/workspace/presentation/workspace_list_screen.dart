import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:student_sphere/features/workspace/domain/workspace_entity.dart';
import 'package:student_sphere/features/workspace/presentation/workspace_controller.dart';

class WorkspaceListScreen extends ConsumerWidget {
  const WorkspaceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspaceState = ref.watch(workspaceControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Workspaces')),
      body: workspaceState.when(
        data: (workspaces) {
          if (workspaces.isEmpty) {
            return const Center(
                child: Text('No workspaces found. Create one!'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: workspaces.length,
            itemBuilder: (context, index) {
              return _WorkspaceCard(workspace: workspaces[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateWorkspaceDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateWorkspaceDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Workspace'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Workspace Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                ref.read(workspaceControllerProvider.notifier).createWorkspace(
                      nameController.text,
                      descController.text,
                    );
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

class _WorkspaceCard extends StatelessWidget {
  final WorkspaceEntity workspace;

  const _WorkspaceCard({required this.workspace});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(workspace.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(workspace.description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          context.go('/home/workspaces/${workspace.id}');
        },
      ),
    );
  }
}

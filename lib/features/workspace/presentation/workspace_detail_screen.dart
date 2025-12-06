import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_sphere/features/workspace/domain/workspace_entity.dart';
import 'package:student_sphere/features/workspace/presentation/workspace_controller.dart';
import 'package:student_sphere/features/auth/presentation/auth_controller.dart';

class WorkspaceDetailScreen extends ConsumerWidget {
  final String workspaceId;

  const WorkspaceDetailScreen({super.key, required this.workspaceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspaceState = ref.watch(workspaceControllerProvider);
    final currentUser = ref.watch(authControllerProvider).value;

    return Scaffold(
      appBar: AppBar(title: const Text('Workspace Details')),
      body: workspaceState.when(
        data: (workspaces) {
          final workspace = workspaces.firstWhere(
            (w) => w.id == workspaceId,
            orElse: () => WorkspaceEntity(
              id: '',
              name: 'Not Found',
              description: '',
              ownerId: '',
              memberIds: [],
              createdAt: DateTime.now(),
            ),
          );

          if (workspace.id.isEmpty) {
            return const Center(child: Text('Workspace not found'));
          }

          final isOwner = currentUser?.id == workspace.ownerId;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workspace.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  workspace.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Members (${workspace.memberIds.length})',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    if (isOwner)
                      IconButton(
                        icon: const Icon(Icons.person_add),
                        onPressed: () => _showInviteDialog(context, ref),
                      ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: workspace.memberIds.length,
                    itemBuilder: (context, index) {
                      final memberId = workspace.memberIds[index];
                      // In a real app, we'd fetch user details here.
                      // For now, we'll just show the ID or a placeholder.
                      return ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title:
                            Text(memberId == currentUser?.id ? 'You' : 'User'),
                        subtitle: Text(memberId),
                        trailing: isOwner && memberId != currentUser?.id
                            ? IconButton(
                                icon: const Icon(Icons.remove_circle_outline,
                                    color: Colors.red),
                                onPressed: () {
                                  ref
                                      .read(
                                          workspaceControllerProvider.notifier)
                                      .removeMember(workspaceId, memberId);
                                },
                              )
                            : null,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  void _showInviteDialog(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invite Member'),
        content: TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email Address',
            hintText: 'user@example.com',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (emailController.text.isNotEmpty) {
                ref.read(workspaceControllerProvider.notifier).addMember(
                      workspaceId,
                      emailController.text.trim(),
                    );
                Navigator.pop(context);
              }
            },
            child: const Text('Invite'),
          ),
        ],
      ),
    );
  }
}

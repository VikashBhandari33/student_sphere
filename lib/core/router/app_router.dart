import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/auth/presentation/auth_controller.dart';
import 'package:student_sphere/features/auth/presentation/login_screen.dart';
import 'package:student_sphere/features/auth/presentation/register_screen.dart';
import 'package:student_sphere/features/auth/presentation/forgot_password_screen.dart';
import 'package:student_sphere/features/timetable/presentation/timetable_screen.dart';
import 'package:student_sphere/features/timetable/presentation/add_class_screen.dart';
import 'package:student_sphere/features/attendance/presentation/attendance_screen.dart';
import 'package:student_sphere/features/workspace/presentation/workspace_list_screen.dart';
import 'package:student_sphere/features/notes/presentation/note_list_screen.dart';
import 'package:student_sphere/features/notes/presentation/note_editor_screen.dart';
import 'package:student_sphere/features/assignments/presentation/assignment_list_screen.dart';
import 'package:student_sphere/features/assignments/presentation/add_assignment_screen.dart';
import 'package:student_sphere/features/events/presentation/calendar_screen.dart';
import 'package:student_sphere/features/events/presentation/add_event_screen.dart';
import 'package:student_sphere/features/settings/presentation/settings_screen.dart';
import 'package:student_sphere/features/ai/presentation/gemini_chat_screen.dart';

// Home Screen
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentSphere'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/home/settings'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const GeminiChatScreen()),
          );
        },
        icon: const Icon(Icons.auto_awesome),
        label: const Text('Ask AI'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _HomeCard(
            icon: Icons.calendar_today,
            title: 'Timetable',
            color: Colors.blue,
            onTap: () => context.go('/home/timetable'),
          ),
          _HomeCard(
            icon: Icons.check_circle_outline,
            title: 'Attendance',
            color: Colors.green,
            onTap: () => context.go('/home/attendance'),
          ),
          _HomeCard(
            icon: Icons.group_work,
            title: 'Workspaces',
            color: Colors.orange,
            onTap: () => context.go('/home/workspaces'),
          ),
          _HomeCard(
            icon: Icons.assignment,
            title: 'Assignments',
            color: Colors.red,
            onTap: () => context.go('/home/assignments'),
          ),
          _HomeCard(
            icon: Icons.note,
            title: 'Notes',
            color: Colors.purple,
            onTap: () => context.go('/home/notes'),
          ),
          _HomeCard(
            icon: Icons.event,
            title: 'Calendar',
            color: Colors.teal,
            onTap: () => context.go('/home/calendar'),
          ),
        ],
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _HomeCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, size: 30, color: color),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/home',
    refreshListenable: AuthStateListenable(authState),
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isLoggingIn = state.uri.toString() == '/login';
      final isRegistering = state.uri.toString() == '/register';
      final isResettingPassword = state.uri.toString() == '/forgot-password';

      if (!isLoggedIn) {
        if (isLoggingIn || isRegistering || isResettingPassword) return null;
        return '/login';
      }

      if (isLoggingIn || isRegistering || isResettingPassword) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'timetable',
            builder: (context, state) => const TimetableScreen(),
            routes: [
              GoRoute(
                path: 'add',
                builder: (context, state) => const AddClassScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'attendance',
            builder: (context, state) => const AttendanceScreen(),
          ),
          GoRoute(
            path: 'workspaces',
            builder: (context, state) => const WorkspaceListScreen(),
          ),
          GoRoute(
            path: 'notes',
            builder: (context, state) => const NoteListScreen(),
            routes: [
              GoRoute(
                path: 'add',
                builder: (context, state) => const NoteEditorScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'assignments',
            builder: (context, state) => const AssignmentListScreen(),
            routes: [
              GoRoute(
                path: 'add',
                builder: (context, state) => const AddAssignmentScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'calendar',
            builder: (context, state) => const CalendarScreen(),
            routes: [
              GoRoute(
                path: 'add',
                builder: (context, state) => const AddEventScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
});

class AuthStateListenable extends ChangeNotifier {
  final AsyncValue<dynamic> authState;

  AuthStateListenable(this.authState);
}

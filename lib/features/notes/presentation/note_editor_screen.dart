import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_sphere/features/notes/presentation/note_controller.dart';
import 'package:student_sphere/features/notes/domain/note_entity.dart';

import 'package:student_sphere/features/ai/data/gemini_service.dart';

class NoteEditorScreen extends ConsumerStatefulWidget {
  final String? noteId;
  const NoteEditorScreen({super.key, this.noteId});

  @override
  ConsumerState<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends ConsumerState<NoteEditorScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isInitialized = false;
  bool _isGenerating = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized && widget.noteId != null) {
      final notes = ref.watch(noteControllerProvider).value;
      if (notes != null) {
        final note = notes.firstWhere((n) => n.id == widget.noteId,
            orElse: () => NoteEntity(
                  id: '',
                  title: '',
                  content: '',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ));
        if (note.id.isNotEmpty) {
          _titleController.text = note.title;
          _contentController.text = note.content;
        }
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_titleController.text.isNotEmpty) {
      if (widget.noteId != null) {
        final notes = ref.read(noteControllerProvider).value;
        final existingNote = notes?.firstWhere((n) => n.id == widget.noteId);
        if (existingNote != null) {
          ref.read(noteControllerProvider.notifier).updateNote(
                existingNote.copyWith(
                  title: _titleController.text,
                  content: _contentController.text,
                  updatedAt: DateTime.now(),
                ),
              );
        }
      } else {
        ref.read(noteControllerProvider.notifier).addNote(
              _titleController.text,
              _contentController.text,
            );
      }
      context.pop();
    }
  }

  Future<void> _showGenerateDialog() async {
    final promptController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Generate with AI'),
        content: TextField(
          controller: promptController,
          decoration: const InputDecoration(
            hintText: 'Enter a prompt (e.g., "Summary of photosynthesis")',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(context);
              _generateContent(promptController.text);
            },
            icon: const Icon(Icons.auto_awesome),
            label: const Text('Generate'),
          ),
        ],
      ),
    );
  }

  Future<void> _generateContent(String prompt) async {
    if (prompt.isEmpty) return;

    setState(() => _isGenerating = true);
    try {
      final content =
          await ref.read(geminiServiceProvider).generateNoteContent(prompt);

      if (mounted) {
        setState(() {
          if (_contentController.text.isEmpty) {
            _contentController.text = content;
          } else {
            _contentController.text += '\n\n$content';
          }
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isGenerating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteId != null ? 'Edit Note' : 'New Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            tooltip: 'Generate with AI',
            onPressed: _showGenerateDialog,
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            if (_isGenerating) const LinearProgressIndicator(),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'Start typing...',
                  border: InputBorder.none,
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

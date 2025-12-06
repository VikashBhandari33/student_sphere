import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/notes/data/note_repository_impl.dart';
import 'package:student_sphere/features/notes/domain/note_entity.dart';
import 'package:student_sphere/features/notes/domain/note_repository.dart';

final noteControllerProvider =
    StateNotifierProvider<NoteController, AsyncValue<List<NoteEntity>>>((ref) {
  return NoteController(ref.watch(noteRepositoryProvider));
});

class NoteController extends StateNotifier<AsyncValue<List<NoteEntity>>> {
  final NoteRepository _repository;

  NoteController(this._repository) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _repository.getNotes().listen((notes) {
      state = AsyncValue.data(notes);
    });
  }

  Future<void> addNote(String title, String content) async {
    final result = await _repository.addNote(title, content);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }

  Future<void> updateNote(NoteEntity note) async {
    final result = await _repository.updateNote(note);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }

  Future<void> deleteNote(String id) async {
    final result = await _repository.deleteNote(id);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }
}

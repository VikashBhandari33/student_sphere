import 'package:dartz/dartz.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/notes/domain/note_entity.dart';

abstract class NoteRepository {
  Stream<List<NoteEntity>> getNotes();
  Future<Either<Failure, void>> addNote(String title, String content);
  Future<Either<Failure, void>> updateNote(NoteEntity note);
  Future<Either<Failure, void>> deleteNote(String id);
}

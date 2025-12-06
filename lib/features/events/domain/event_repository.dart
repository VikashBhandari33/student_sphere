import 'package:dartz/dartz.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/events/domain/event_entity.dart';

abstract class EventRepository {
  Stream<List<EventEntity>> getEvents();
  Future<Either<Failure, void>> addEvent(EventEntity event);
  Future<Either<Failure, void>> deleteEvent(String id);
}

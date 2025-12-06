import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/events/data/event_repository_impl.dart';
import 'package:student_sphere/features/events/domain/event_entity.dart';
import 'package:student_sphere/features/events/domain/event_repository.dart';

final eventControllerProvider =
    StateNotifierProvider<EventController, AsyncValue<List<EventEntity>>>(
        (ref) {
  return EventController(ref.watch(eventRepositoryProvider));
});

class EventController extends StateNotifier<AsyncValue<List<EventEntity>>> {
  final EventRepository _repository;

  EventController(this._repository) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _repository.getEvents().listen((events) {
      state = AsyncValue.data(events);
    });
  }

  Future<void> addEvent(EventEntity event) async {
    final result = await _repository.addEvent(event);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }

  Future<void> deleteEvent(String id) async {
    final result = await _repository.deleteEvent(id);
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {},
    );
  }
}

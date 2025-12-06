import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimetableSettings {
  final int startHour;
  final int endHour;
  final bool showWeekends;

  const TimetableSettings({
    this.startHour = 8,
    this.endHour = 18,
    this.showWeekends = false,
  });

  TimetableSettings copyWith({
    int? startHour,
    int? endHour,
    bool? showWeekends,
  }) {
    return TimetableSettings(
      startHour: startHour ?? this.startHour,
      endHour: endHour ?? this.endHour,
      showWeekends: showWeekends ?? this.showWeekends,
    );
  }
}

class TimetableSettingsNotifier extends StateNotifier<TimetableSettings> {
  TimetableSettingsNotifier() : super(const TimetableSettings());

  void updateStartHour(int hour) {
    state = state.copyWith(startHour: hour);
  }

  void updateEndHour(int hour) {
    state = state.copyWith(endHour: hour);
  }

  void toggleWeekends(bool show) {
    state = state.copyWith(showWeekends: show);
  }
}

final timetableSettingsProvider =
    StateNotifierProvider<TimetableSettingsNotifier, TimetableSettings>((ref) {
  return TimetableSettingsNotifier();
});

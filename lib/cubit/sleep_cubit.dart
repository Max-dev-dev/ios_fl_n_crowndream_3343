import 'package:flutter_bloc/flutter_bloc.dart';

class SleepEntryModel {
  final DateTime date;
  final String duration; 

  SleepEntryModel({required this.date, required this.duration});
}

class SleepCubit extends Cubit<List<SleepEntryModel>> {
  SleepCubit() : super([]);

  void addSleepEntry(DateTime date, double hours) {
    final formatted = hours.toStringAsFixed(0).padLeft(2, '0') + ":00";
    final newEntry = SleepEntryModel(date: date, duration: formatted);

    final updatedList = List<SleepEntryModel>.from(state)
      ..removeWhere((e) => _isSameDay(e.date, date))
      ..add(newEntry);

    emit(updatedList);
  }

  bool hasSleepDataForDate(DateTime date) {
    return state.any((entry) => _isSameDay(entry.date, date));
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}


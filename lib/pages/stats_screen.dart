import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_crown_dream_3343/cubit/sleep_cubit.dart';
import 'package:table_calendar/table_calendar.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final selected = _selectedDay ?? _focusedDay;
    final sleepEntry =
        context
            .watch<SleepCubit>()
            .state
            .where((e) => _isSameDay(e.date, selected))
            .cast<SleepEntryModel?>()
            .firstOrNull;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Analytics sleep',
              style: TextStyle(
                color: Color(0xFFAD7942),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate:
                    (day) =>
                        _selectedDay != null && _isSameDay(day, _selectedDay!),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, _) {
                    final isSelected =
                        _selectedDay != null && _isSameDay(day, _selectedDay!);
                    return Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          fontSize: isSelected ? 18 : 14,
                          color:
                              isSelected
                                  ? const Color.fromARGB(255, 239, 170, 96)
                                  : Colors.white,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  todayBuilder: (context, day, _) {
                    return Center(
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFFAD7942),
                          fontWeight: FontWeight.w800
                        ),
                      ),
                    );
                  },
                  selectedBuilder: (context, day, _) {
                    return null;
                  },
                ),

                calendarStyle: CalendarStyle(
                  todayDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  selectedDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  defaultTextStyle: const TextStyle(color: Colors.white),
                  weekendTextStyle: const TextStyle(color: Colors.white),
                ),

                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.white),
                  weekendStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (sleepEntry != null)
              Container(
                width: 280,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF5C4022),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timer, color: Colors.white.withOpacity(0.5)),
                        const SizedBox(width: 8),
                        Text(
                          "You have slept",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      sleepEntry.duration,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            if (_selectedDay != null)
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  "On this day, you did not record your sleep",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

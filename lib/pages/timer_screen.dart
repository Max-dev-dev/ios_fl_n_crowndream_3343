// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_crown_dream_3343/cubit/sleep_cubit.dart';
import 'package:ios_fl_n_crown_dream_3343/services/painter_service.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  TimeOfDay? _bedtime;
  TimeOfDay? _wakeUpTime;
  final DateTime _selectedDate = DateTime.now();
  final List<DateTime> _weekDates = [];
  final Set<DateTime> _sleepLoggedDates = {};
  bool _isCalculated = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    for (int i = 0; i < 7; i++) {
      _weekDates.add(startOfWeek.add(Duration(days: i)));
    }
  }

  double _calculateSleepHours() {
    if (_bedtime == null || _wakeUpTime == null) return 0;
    final bedtimeMinutes = _bedtime!.hour * 60 + _bedtime!.minute;
    final wakeupMinutes = _wakeUpTime!.hour * 60 + _wakeUpTime!.minute;
    int duration = wakeupMinutes - bedtimeMinutes;
    if (duration <= 0) duration += 1440;
    return duration / 60.0;
  }

  @override
  Widget build(BuildContext context) {
    final sleepHours = _calculateSleepHours();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Sleep tracker",
                  style: TextStyle(
                    color: Color(0xFFAD7942),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: CustomPaint(
                    painter: SleepCirclePainter(
                      bedtime: _bedtime,
                      wakeUpTime: _wakeUpTime,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5C4022),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          _weekDates.map((date) {
                            final isFuture = date.isAfter(DateTime.now());

                            final hasSleepData = context
                                .read<SleepCubit>()
                                .hasSleepDataForDate(date);

                            Color borderColor;
                            Color textColor;
                            FontWeight fontWeight;

                            if (isFuture) {
                              borderColor = Colors.transparent;
                              textColor = Colors.white.withOpacity(0.3);
                              fontWeight = FontWeight.normal;
                            } else {
                              borderColor =
                                  hasSleepData
                                      ? const Color(0xFFF1B016)
                                      : Colors.black;
                              textColor = Colors.white;
                              fontWeight = FontWeight.bold;
                            }

                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              padding: const EdgeInsets.all(10),
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: borderColor,
                                  width: 2,
                                ),
                                color: Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: textColor,
                                    fontWeight: fontWeight,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTimeSelector("Bedtime", _bedtime, (selected) {
                      setState(() => _bedtime = selected);
                    }),
                    _buildTimeSelector("Wake up", _wakeUpTime, (selected) {
                      setState(() => _wakeUpTime = selected);
                    }),
                  ],
                ),
                const SizedBox(height: 60),
                if (_bedtime != null && _wakeUpTime != null)
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          final today = DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            _selectedDate.day,
                          );
                          _sleepLoggedDates.add(today);
                          _isCalculated = true;
                        });

                        final today = DateTime(
                          _selectedDate.year,
                          _selectedDate.month,
                          _selectedDate.day,
                        );
                        final hours = _calculateSleepHours();

                        context.read<SleepCubit>().addSleepEntry(today, hours);
                      },
                      child: Container(
                        width: 250,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xFFFFF0B0), Color(0xFFAD7942)],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Calculate',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0F0F1B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 20),
                if (_isCalculated)
                  Center(
                    child: Container(
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
                              Icon(
                                Icons.timer,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              SizedBox(width: 8),
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
                            "${sleepHours.toStringAsFixed(0).padLeft(2, '0')} : 00 hours",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSelector(
    String label,
    TimeOfDay? selectedTime,
    Function(TimeOfDay) onTimeSelected,
  ) {
    final dropdownItems = List.generate(24, (index) {
      final time = TimeOfDay(hour: index, minute: 0);
      final formatted = time.format(context);
      return DropdownMenuItem<TimeOfDay>(
        value: time,
        child: Text(formatted, style: const TextStyle(color: Colors.black)),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        SizedBox(
          width: 140,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFC0945B),
              borderRadius: BorderRadius.circular(16),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<TimeOfDay>(
                value: selectedTime,
                isExpanded: true,
                dropdownColor: const Color(0xFFC0945B),
                iconEnabledColor: Colors.black,
                borderRadius: BorderRadius.circular(16),
                hint: const Text(
                  "-- : --",
                  style: TextStyle(color: Colors.black),
                ),
                items: dropdownItems,
                onChanged: (value) {
                  if (value != null) onTimeSelected(value);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

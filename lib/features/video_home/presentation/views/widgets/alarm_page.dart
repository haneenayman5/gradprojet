import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../../../core/util/app_route.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  List<Map<String, dynamic>> alarms = [];

  @override
  void initState() {
    super.initState();
    loadAlarms();
  }

  Future<void> loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final storedAlarms = prefs.getStringList('alarms') ?? [];
    setState(() {
      alarms = storedAlarms.map((e) => json.decode(e) as Map<String, dynamic>).toList();
    });
  }

  Future<void> saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedAlarms = alarms.map((e) => json.encode(e)).toList();
    await prefs.setStringList('alarms', encodedAlarms);
  }

  void toggleAlarm(int index) {
    setState(() {
      alarms[index]['active'] = !alarms[index]['active'];
    });
    saveAlarms();
  }

  void deleteAlarm(int index) {
    setState(() {
      alarms.removeAt(index);
    });
    saveAlarms();
  }

  void addAlarm(Map<String, dynamic> alarm) {
    setState(() {
      alarms.add(alarm);
    });
    saveAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[500],
      appBar: AppBar(
        backgroundColor: Colors.indigo[500],
        title: const Text(
          'Your alarms',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: List.generate(alarms.length, (index) {
              final alarm = alarms[index];
              return Opacity(
                opacity: alarm['active'] ? 1.0 : 0.3,
                child: AlarmCard(
                  time: alarm['time'],
                  label: alarm['label'],
                  days: List<String>.from(alarm['days']),
                  isActive: alarm['active'],
                  onToggle: () => toggleAlarm(index),
                  onDelete: () => deleteAlarm(index),
                ),
              );
            }),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 72,
        width: 72,
        child: FloatingActionButton(
          backgroundColor: Colors.indigo[700],
          onPressed: () async {
            final newAlarm = await context.push<Map<String, dynamic>>(AppRoute.setAlarmPath);
            if (newAlarm != null) {
              addAlarm(newAlarm);
            }
          },
          child: const Icon(Icons.add, color: Colors.white, size: 36),
        ),
      ),
    );
  }
}

class AlarmCard extends StatelessWidget {
  final String time;
  final String label;
  final List<String> days;
  final bool isActive;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const AlarmCard({
    super.key,
    required this.time,
    required this.label,
    required this.days,
    required this.isActive,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: time,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                        text: " AM",
                        style: TextStyle(fontSize: 18, color: Colors.grey)),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: isActive ? Colors.indigo[700] : Colors.grey,
                    ),
                    onPressed: onToggle,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.indigo[700]),
                    onPressed: onDelete,
                  ),
                ],
              )
            ],
          ),
          if (label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                label,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: days
                .map(
                  (d) => Chip(
                label: Text(d),
                backgroundColor: Colors.indigo[600],
                labelStyle: const TextStyle(color: Colors.white),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}














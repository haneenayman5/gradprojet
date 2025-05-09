// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:untitled3/core/constants/constants.dart';
// import 'dart:convert';
//
// import '../../../../../core/util/app_route.dart';
//
// class AlarmPage extends StatefulWidget {
//   const AlarmPage({super.key});
//
//   @override
//   State<AlarmPage> createState() => _AlarmPageState();
// }
//
// class _AlarmPageState extends State<AlarmPage> {
//   List<Map<String, dynamic>> alarms = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadAlarms();
//   }
//
//   Future<void> loadAlarms() async {
//     final prefs = await SharedPreferences.getInstance();
//     final storedAlarms = prefs.getStringList('alarms') ?? [];
//     setState(() {
//       alarms = storedAlarms.map((e) => json.decode(e) as Map<String, dynamic>).toList();
//     });
//   }
//
//   Future<void> saveAlarms() async {
//     final prefs = await SharedPreferences.getInstance();
//     final encodedAlarms = alarms.map((e) => json.encode(e)).toList();
//     await prefs.setStringList('alarms', encodedAlarms);
//   }
//
//   void toggleAlarm(int index) {
//     setState(() {
//       alarms[index]['active'] = !alarms[index]['active'];
//     });
//     saveAlarms();
//   }
//
//   void deleteAlarm(int index) {
//     setState(() {
//       alarms.removeAt(index);
//     });
//     saveAlarms();
//   }
//
//   void addAlarm(Map<String, dynamic> alarm) {
//     setState(() {
//       alarms.add(alarm);
//     });
//     saveAlarms();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kPrimarycolor,
//       appBar: AppBar(
//         backgroundColor: kPrimarycolor,
//         title: const Text(
//           'Your alarms',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: List.generate(alarms.length, (index) {
//               final alarm = alarms[index];
//               return Opacity(
//                 opacity: alarm['active'] ? 1.0 : 0.3,
//                 child: AlarmCard(
//                   time: alarm['time'],
//                   label: alarm['label'],
//                   days: List<String>.from(alarm['days']),
//                   isActive: alarm['active'],
//                   onToggle: () => toggleAlarm(index),
//                   onDelete: () => deleteAlarm(index),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: SizedBox(
//         height: 72,
//         width: 72,
//         child: FloatingActionButton(
//           backgroundColor: kPrimarycolor,
//           onPressed: () async {
//             final newAlarm = await context.push<Map<String, dynamic>>(AppRoute.setAlarmPath);
//             if (newAlarm != null) {
//               addAlarm(newAlarm);
//             }
//           },
//           child: const Icon(Icons.add, color: Colors.white, size: 36),
//         ),
//       ),
//     );
//   }
// }

// class AlarmCard extends StatelessWidget {
//   final String time;
//   final String label;
//   final List<String> days;
//   final bool isActive;
//   final VoidCallback onToggle;
//   final VoidCallback onDelete;
//
//   const AlarmCard({
//     super.key,
//     required this.time,
//     required this.label,
//     required this.days,
//     required this.isActive,
//     required this.onToggle,
//     required this.onDelete,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text.rich(
//                 TextSpan(
//                   children: [
//                     TextSpan(
//                       text: time,
//                       style: const TextStyle(
//                           fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     const TextSpan(
//                         text: " AM",
//                         style: TextStyle(fontSize: 18, color: Colors.grey)),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       Icons.notifications,
//                       color: isActive ? kPrimarycolor : Colors.grey,
//                     ),
//                     onPressed: onToggle,
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.delete, color: kPrimarycolor),
//                     onPressed: onDelete,
//                   ),
//                 ],
//               )
//             ],
//           ),
//           if (label.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(top: 4.0),
//               child: Text(
//                 label,
//                 style: const TextStyle(
//                     fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//             ),
//           const SizedBox(height: 8),
//           Wrap(
//             spacing: 6,
//             children: days
//                 .map(
//                   (d) => Chip(
//                 label: Text(d),
//                 backgroundColor: kPrimarycolor,
//                 labelStyle: const TextStyle(color: Colors.white),
//               ),
//             )
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/core/constants/constants.dart';
import '../../domain/entities/alarm_entity.dart';
import '../bloc/alarm_list/alarm_list_cubit.dart';
import '../../../../../core/util/app_route.dart';

/// Displays list of alarms and allows add, toggle, delete via AlarmListCubit.
class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<AlarmListCubit>()..loadAlarms(),      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimarycolor,
          title: const Text('Your Alarms', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 4,
        ),
        body: BlocBuilder<AlarmListCubit, AlarmListState>(
          builder: (context, state) {
            if (state is AlarmListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AlarmListLoaded) {
              final alarms = state.alarms;
              if (alarms.isEmpty) {
                return Center(
                  child: Text('No alarms yet', style: TextStyle(color: Colors.grey[600], fontSize: 18)),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: alarms.length,
                itemBuilder: (context, index) {
                  final alarm = alarms[index];
                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: alarm.isEnabled ? 1 : 0.5,
                    child: Card(
                      elevation: 6,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        title: Text(
                          DateFormat('hh:mm a').format(alarm.time),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: alarm.isEnabled ? Colors.black : Colors.grey,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (alarm.label.isNotEmpty)
                              Text(alarm.label,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: alarm.isEnabled ? Colors.black87 : Colors.grey)),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              children: alarm.repeatDays
                                  .map((d) => Chip(
                                label: Text(d.name),
                                backgroundColor: alarm.isEnabled
                                    ? Colors.deepPurpleAccent
                                    : Colors.grey[300],
                                labelStyle: TextStyle(
                                    color: alarm.isEnabled ? Colors.white : Colors.grey[700]),
                              ))
                                  .toList(),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                alarm.isEnabled ? Icons.toggle_on : Icons.toggle_off,
                                size: 32,
                                color: Colors.deepPurple,
                              ),
                              onPressed: () => context.read<AlarmListCubit>().toggleAlarm(alarm),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
                              onPressed: () => context.read<AlarmListCubit>().removeAlarm(alarm.id),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is AlarmListError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () async {
            final newAlarm = await context.push<Alarm>(AppRoute.setAlarmPath);
            if (newAlarm != null) {
              context.read<AlarmListCubit>().addAlarm(newAlarm);
            }
          },
          child: const Icon(Icons.add, size: 32),
        ),
      ),
    );
  }
}
// import 'package:flutter/cupertino.dart';
//
// class SoundMonitorPage extends StatelessWidget {
//   const SoundMonitorPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => SoundMonitorCubit(monitorSound: context.read<MonitorSound>()),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Sound Monitor')),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: BlocBuilder<SoundMonitorCubit, SoundMonitorState>(
//                   builder: (context, state) {
//                     final level = state is SoundMonitorRunning ? state.dbLevel : 0.0;
//                     return SfRadialGauge(
//                       axes: <RadialAxis>[
//                         RadialAxis(
//                           minimum: 0,
//                           maximum: 120,
//                           pointers: <GaugePointer>[
//                             NeedlePointer(value: level),
//                           ],
//                           annotations: <GaugeAnnotation>[
//                             GaugeAnnotation(
//                               widget: Text(
//                                 '${level.toStringAsFixed(1)} dB',
//                                 style: const TextStyle(
//                                     fontSize: 24, fontWeight: FontWeight.bold),
//                               ),
//                               angle: 90,
//                               positionFactor: 0.5,
//                             ),
//                           ],
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => context.read<SoundMonitorCubit>().startMonitoring(),
//                     child: const Text('Start'),
//                   ),
//                   const SizedBox(width: 20),
//                   ElevatedButton(
//                     onPressed: () => context.read<SoundMonitorCubit>().stopMonitoring(),
//                     child: const Text('Stop'),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

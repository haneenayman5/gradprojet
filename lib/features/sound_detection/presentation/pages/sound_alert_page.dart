import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'emergency_alert_page.dart';
import 'package:untitled3/core/util/app_route.dart';
import 'package:go_router/go_router.dart';

class SoundAlertPage extends StatefulWidget {
  @override
  _SoundAlertPageState createState() => _SoundAlertPageState();
}

class _SoundAlertPageState extends State<SoundAlertPage> with SingleTickerProviderStateMixin {
  double decibelLevel = 56;
  double loudNoiseThreshold = 69;

  late AnimationController _controller;
  late Animation<double> _animation;

  Map<String, bool> soundTriggers = {
    "Smoke Alarm": false,
    "Fire Alarm": false,
    "Doorbell": true,
    "Siren": false,
    "Buzzer": false,
    "Beep": false,
    "Baby Cry": false,
  };

  bool isLoudNoiseEnabled = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextStyle get headingStyle => const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.indigo);
  TextStyle get subheadingStyle => const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87);
  TextStyle get labelStyle => const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.indigo),
          onPressed: () => GoRouter.of(context).go(AppRoute.chatHomePath),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.indigo),
        title: const Text(
          "Sound Alert",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.indigo),
        ),
        backgroundColor: Colors.indigo[50],
        shape: const Border(bottom: BorderSide(color: Colors.indigo, width: 2)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EmergencyAlertPage(
                    detectedSound: 'Doorbell',
                    confidenceLevel: 0.77,
                  ),
                ),
              );
            },
            child: const Text(
              "Next",
              style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDecibelGauge(),
          const SizedBox(height: 24),
          _buildSoundDetection(),
          const SizedBox(height: 24),
          _buildSoundTriggers(),
        ],
      ),
    );
  }

  Widget _buildDecibelGauge() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Decibel Level", style: headingStyle),
            const SizedBox(height: 12),
            SfRadialGauge(
              axes: [
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  ranges: [
                    GaugeRange(startValue: 0, endValue: 60, color: Colors.indigoAccent),
                    GaugeRange(startValue: 60, endValue: 80, color: Colors.lightBlueAccent),
                    GaugeRange(startValue: 80, endValue: 100, color: Colors.blueAccent),
                  ],
                  pointers: [NeedlePointer(value: decibelLevel)],
                  annotations: [
                    GaugeAnnotation(
                      widget: Text('${decibelLevel.toInt()} dB',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      angle: 90,
                      positionFactor: 0.5,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSoundDetection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sound Detection", style: headingStyle),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.hearing, color: Colors.indigo, size: 30),
                const SizedBox(width: 10),
                Text("Listening for sounds...", style: subheadingStyle),
                const Spacer(),
                ScaleTransition(
                  scale: _animation,
                  child: const Icon(Icons.circle, size: 16, color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 30,
                itemBuilder: (_, index) {
                  final height = (index % 5 + 1) * 20.0;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 6,
                    height: height,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: Colors.indigo[400],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text("Currently detecting: All sounds", style: labelStyle),
          ],
        ),
      ),
    );
  }

  Widget _buildSoundTriggers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Sound Triggers", style: headingStyle),
        const SizedBox(height: 12),
        _buildLoudNoiseTrigger(),
        ...soundTriggers.entries.map((entry) {
          final isActive = entry.value;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: isActive ? Colors.indigo[100] : Colors.indigo[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: SwitchListTile(
              title: Row(
                children: [
                  Icon(_getIcon(entry.key), size: 25, color: Colors.indigo),
                  const SizedBox(width: 10),
                  Text(entry.key, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ],
              ),
              subtitle: Text(_getSubtitle(entry.key), style: const TextStyle(fontSize: 16, color: Colors.black87)),
              value: isActive,
              activeColor: Colors.indigo,
              inactiveThumbColor: Colors.grey,
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white,
              onChanged: (val) => setState(() => soundTriggers[entry.key] = val),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildLoudNoiseTrigger() {
    return Card(
      color: Colors.indigo[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.volume_up, color: Colors.indigo, size: 28),
                const SizedBox(width: 10),
                Text("Loud Noise", style: subheadingStyle),
                const Spacer(),
                Switch(
                  value: isLoudNoiseEnabled,
                  activeColor: Colors.indigo,
                  onChanged: (val) => setState(() => isLoudNoiseEnabled = val),
                ),
              ],
            ),
            Text("Detects when sound exceeds threshold", style: labelStyle),
            Slider(
              min: 40,
              max: 100,
              divisions: 60,
              value: loudNoiseThreshold,
              label: "${loudNoiseThreshold.toInt()} dB",
              activeColor: Colors.indigo,
              onChanged: (val) => setState(() => loudNoiseThreshold = val),
            ),
          ],
        ),
      ),
    );
  }

  String _getSubtitle(String trigger) {
    switch (trigger) {
      case "Smoke Alarm":
        return "Recognizes standard smoke alarm sounds";
      case "Fire Alarm":
        return "Detects fire alarm patterns";
      case "Doorbell":
        return "Identifies doorbell sounds";
      case "Siren":
        return "Detects emergency vehicle sirens";
      case "Buzzer":
        return "Recognizes buzzer sounds";
      case "Beep":
        return "Identifies electronic beeping";
      case "Baby Cry":
        return "Detects baby cry sounds";
      default:
        return "";
    }
  }

  IconData _getIcon(String trigger) {
    switch (trigger) {
      case "Smoke Alarm":
        return Icons.smoke_free;
      case "Fire Alarm":
        return Icons.local_fire_department;
      case "Doorbell":
        return Icons.doorbell;
      case "Siren":
        return Icons.emergency;
      case "Buzzer":
        return Icons.campaign;
      case "Beep":
        return Icons.sensors;
      case "Baby Cry":
        return Icons.child_care;
      default:
        return Icons.music_note;
    }
  }
}

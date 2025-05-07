import 'package:flutter/material.dart';

class SetAlarmPage extends StatefulWidget {
  const SetAlarmPage({super.key});

  @override
  State<SetAlarmPage> createState() => _SetAlarmPageState();
}

class _SetAlarmPageState extends State<SetAlarmPage> {
  final List<String> allDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  Set<String> selectedDays = {'Mo', 'Tu', 'We', 'Th', 'Fr'};

  int hour = 6;
  int minute = 0;
  bool isAm = true;

  double alarmVolume = 0.7;
  bool vibrationEnabled = true;
  String vibrationStrength = 'Medium';
  bool useFlashlight = false;
  bool showPopup = true;
  String alarmNote = '';

  void incrementHour() => setState(() => hour = (hour + 1) % 24);
  void decrementHour() => setState(() => hour = (hour - 1 + 24) % 24);
  void incrementMinute() => setState(() => minute = (minute + 1) % 60);
  void decrementMinute() => setState(() => minute = (minute - 1 + 60) % 60);

  String formatTimeUnit(int unit) => unit.toString().padLeft(2, '0');
  String displayHour12(int hour) {
    final h = hour % 12;
    return (h == 0 ? 12 : h).toString().padLeft(2, '0');
  }

  int getFinalHour() {
    final base = hour % 12;
    return isAm ? base : base + 12;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Alarm',
            style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard([
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _TimeAdjustButton(
                  value: displayHour12(hour),
                  onIncrement: () => setState(() => hour = (hour + 1) % 24),
                  onDecrement: () => setState(() => hour = (hour - 1 + 24) % 24),
                ),
                const SizedBox(width: 10),
                const Text(":", style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                _TimeAdjustButton(
                  value: formatTimeUnit(minute),
                  onIncrement: incrementMinute,
                  onDecrement: decrementMinute,
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => isAm = true),
                      child: Text(
                        "AM",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isAm ? Colors.indigo[700] : Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => setState(() => isAm = false),
                      child: Text(
                        "PM",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: !isAm ? Colors.indigo[700] : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ]),
          const SizedBox(height: 16),

          // Repeat section
          _buildCard([
            _sectionHeader(Icons.calendar_today, "Repeat"),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: allDays.map((d) {
                final selected = selectedDays.contains(d);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selected) {
                        selectedDays.remove(d);
                      } else {
                        selectedDays.add(d);
                      }
                    });
                  },
                  child: Chip(
                    label: Text(d),
                    backgroundColor: selected ? Colors.indigo[700] : Colors.grey[300],
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            )
          ]),
          const SizedBox(height: 16),

          // Alarm Sound and Volume
          _buildCard([
            _sectionHeader(Icons.notifications_none, "Alarm sound"),
            const SizedBox(height: 8),
            const Text("Alarm tone: Alarm Ringtone",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Slider(
              value: alarmVolume,
              onChanged: (value) => setState(() => alarmVolume = value),
              activeColor: Colors.indigo[900],
              inactiveColor: Colors.indigo[100],
            ),
          ]),
          const SizedBox(height: 16),

          // Note
          _buildCard([
            _sectionHeader(Icons.note_alt_outlined, "Note"),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: "Add a note for this alarm",
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() => alarmNote = val),
            ),
          ]),
          const SizedBox(height: 16),

          // Vibration
          _buildCard([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.vibration),
                    SizedBox(width: 8),
                    Text("Vibration", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Switch(
                  value: vibrationEnabled,
                  onChanged: (val) => setState(() => vibrationEnabled = val),
                  activeColor: Colors.indigo[700],
                ),
              ],
            ),
            const SizedBox(height: 12),
            _dropdownField("Strength", vibrationStrength, ["Low", "Medium", "High"],
                enabled: vibrationEnabled),
          ]),
          const SizedBox(height: 16),

          // Flashlight + Popup
          _buildCard([
            SwitchListTile(
              value: useFlashlight,
              onChanged: (val) => setState(() => useFlashlight = val),
              title: const Text("Use flashlight", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              secondary: const Icon(Icons.flashlight_on),
              activeColor: Colors.indigo[700],
            ),
            SwitchListTile(
              value: showPopup,
              onChanged: (val) => setState(() => showPopup = val),
              title: const Text("Show on-screen popup", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              secondary: const Icon(Icons.alarm),
              activeColor: Colors.indigo[700],
            ),
          ]),
          const SizedBox(height: 90),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 72,
        width: 72,
        child: FloatingActionButton(
          backgroundColor: Colors.indigo[700],
          child: const Icon(Icons.check, size: 36 , color: Colors.white),
          onPressed: () {
            final int finalHour = getFinalHour();
            final String timeString = '${formatTimeUnit(finalHour)}:${formatTimeUnit(minute)}';
            final Map<String, dynamic> newAlarm = {
              "time": timeString,
              "label": alarmNote,
              "days": selectedDays.toList(),
              "active": true,
            };
            Navigator.of(context).pop(newAlarm);
          },
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  static Widget _sectionHeader(IconData icon, String title) => Row(
    children: [
      Icon(icon),
      const SizedBox(width: 8),
      Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ],
  );

  static Widget _dropdownField(String label, String value, List<String> items, {bool enabled = true}) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: enabled ? (_) {} : null,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

class _TimeAdjustButton extends StatelessWidget {
  final String value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _TimeAdjustButton({
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(icon: const Icon(Icons.add, color: Colors.indigo), onPressed: onIncrement),
        Text(value, style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold)),
        IconButton(icon: const Icon(Icons.remove, color: Colors.indigo), onPressed: onDecrement),
      ],
    );
  }
}













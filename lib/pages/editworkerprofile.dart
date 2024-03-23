import 'package:flutter/material.dart';

import 'dashboard_page.dart';

class EditWorkerProfile extends StatefulWidget {
  @override
  _EditWorkerProfileState createState() => _EditWorkerProfileState();
}

class _EditWorkerProfileState extends State<EditWorkerProfile> {
  final TextEditingController workerNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String selectedField = 'Plumbing';
  TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 17, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Worker Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: workerNameController,
              decoration: const InputDecoration(labelText: 'Worker Name'),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedField,
              onChanged: (value) {
                setState(() {
                  selectedField = value!;
                });
              },
              items: ['Plumbing', 'Painting', 'Welding']
                  .map<DropdownMenuItem<String>>((String field) {
                return DropdownMenuItem<String>(
                  value: field,
                  child: Text(field),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Worker Field'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Worker Phone Number'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Worker Location'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Working Hours:'),
                _buildTimePicker('Start Time', startTime, (time) {
                  setState(() {
                    startTime = time!;
                  });
                }),
                const Text('to'),
                _buildTimePicker('End Time', endTime, (time) {
                  setState(() {
                    endTime = time!;
                  });
                }),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveUserProfile();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker(
      String label, TimeOfDay time, Function(TimeOfDay?) onTimeChanged) {
    return InkWell(
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: time,
        );
        if (pickedTime != null && pickedTime != time) {
          onTimeChanged(pickedTime);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text('$label: ${time.format(context)}'),
      ),
    );
  }

  void _saveUserProfile() {
    ('Saving user profile...');
    ('Worker Name: ${workerNameController.text}');
    ('Worker Field: $selectedField');
    ('Worker Phone Number: ${phoneNumberController.text}');
    ('Worker Location: ${locationController.text}');
    ('Working Hours: ${startTime.format(context)} to ${endTime.format(context)}');
  }
}

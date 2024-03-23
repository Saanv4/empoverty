import 'package:flutter/material.dart';
import 'worker_box_user.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<ServiceRequest> serviceRequests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              _showAddServicePopup(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            WorkerBox(
              workerName: 'John Doe',
              workerField: 'Painting',
              phoneNumber: '123-456-7890',
              recommender: 'Shop Owner 1',
            ),
            WorkerBox(
              workerName: 'Jane Doe',
              workerField: 'Painting',
              phoneNumber: '987-654-3210',
              recommender: 'Shop Owner 2',
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Your Requests',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            for (ServiceRequest request in serviceRequests)
              ListTile(
                title: Text('Location: ${request.location}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Domain of Work: ${request.domainOfWork}'),
                    Text('Time of Service Needed: ${request.timeNeeded}'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddServicePopup(BuildContext context) async {
    TextEditingController locationController = TextEditingController();
    String selectedDomain = 'Plumbing';
    String selectedTime = '8:00';

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Service'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedDomain,
                onChanged: (value) {
                  selectedDomain = value!;
                },
                items: ['Plumbing', 'Painting', 'Welding']
                    .map<DropdownMenuItem<String>>((String domain) {
                  return DropdownMenuItem<String>(
                    value: domain,
                    child: Text(domain),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Domain of Work',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedTime,
                onChanged: (value) {
                  selectedTime = value!;
                },
                items: [
                  '8:00',
                  '8:30',
                  '9:00',
                  '9:30',
                  '10:00',
                  '10:30',
                  '11:00',
                  '11:30',
                  '12:00',
                  '12:30',
                  '1:00'
                ].map<DropdownMenuItem<String>>((String time) {
                  return DropdownMenuItem<String>(
                    value: time,
                    child: Text(time),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Time of Service Needed',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                ('Location: ${locationController.text}');
                ('Domain of Work: $selectedDomain');
                ('Time of Service Needed: $selectedTime');
                _saveServiceRequest(
                    locationController.text, selectedDomain, selectedTime);
                Navigator.of(context).pop();
              },
              child: const Text('Add Service'),
            ),
          ],
        );
      },
    );
  }

  void _saveServiceRequest(
      String location, String domainOfWork, String timeNeeded) {
    setState(() {
      serviceRequests.add(ServiceRequest(location, domainOfWork, timeNeeded));
    });
  }
}

class ServiceRequest {
  final String location;
  final String domainOfWork;
  final String timeNeeded;

  ServiceRequest(this.location, this.domainOfWork, this.timeNeeded);
}

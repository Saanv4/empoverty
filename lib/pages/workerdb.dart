import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class Worker {
  final String workerName;
  final String workerField;
  final String workerPhoneNumber;
  final String workerEmail;
  final String workerLocation;
  final String workingHours;
  final List<dynamic> recommendationList;
  final List<dynamic> pendingRequests;
  final List<dynamic> acceptedupcomingRequests;
  final List<dynamic> pastRequests;

  Worker({
    required this.workerName,
    required this.workerField,
    required this.workerPhoneNumber,
    required this.workerEmail,
    required this.workerLocation,
    required this.workingHours,
    required this.pendingRequests,
    required this.acceptedupcomingRequests,
    required this.pastRequests,
    required this.recommendationList,
  });

  Map<String, dynamic> toJson() => {
    'workerName': workerName,
    'workerField': workerField,
    'workerPhoneNumber': workerPhoneNumber,
    'workerEmail': workerEmail,
    'workerLocation': workerLocation,
    'workingHours': workingHours,
    'pendingRequests': pendingRequests,
    'recommendationList': recommendationList,
    'acceptedupcomingRequests': acceptedupcomingRequests,
    'pastRequests': pastRequests,
  };

  static Worker fromJson(Map<String, dynamic> json) => Worker(
    recommendationList: json['recommendationList'],
    workerName: json['workerName'],
    workerField: json['workerField'],
    workerPhoneNumber: json['workerPhoneNumber'],
    workerEmail: json['workerEmail'],
    workerLocation: json['workerLocation'],
    workingHours: json['workingHours'],
    pendingRequests: json['pendingRequests'],
    acceptedupcomingRequests: json['acceptedupcomingRequests'],
    pastRequests: json['pastRequests'],
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WorkerForm(),
    );
  }
}

class WorkerForm extends StatefulWidget {
  @override
  _WorkerFormState createState() => _WorkerFormState();
}

class _WorkerFormState extends State<WorkerForm> {
  final TextEditingController workerNameController = TextEditingController();
  final TextEditingController workerFieldController = TextEditingController();
  final TextEditingController workerPhoneNumberController =
  TextEditingController();
  final TextEditingController workerEmailController = TextEditingController();
  final TextEditingController workerLocationController = TextEditingController();
  final TextEditingController workingHoursController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Worker Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: workerNameController,
              decoration: InputDecoration(labelText: 'Worker Name'),
            ),
            TextFormField(
              controller: workerFieldController,
              decoration: InputDecoration(labelText: 'Worker Field'),
            ),
            TextFormField(
              controller: workerPhoneNumberController,
              decoration: InputDecoration(labelText: 'Worker Phone Number'),
            ),
            TextFormField(
              controller: workerEmailController,
              decoration: InputDecoration(labelText: 'Worker Email'),
            ),
            TextFormField(
              controller: workerLocationController,
              decoration: InputDecoration(labelText: 'Worker Location'),
            ),
            TextFormField(
              controller: workingHoursController,
              decoration: InputDecoration(labelText: 'Working Hours'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                saveWorkerData();
              },
              child: Text('Save Worker Data'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveWorkerData() async {
    try {
      Worker newWorker = Worker(
        workerName: workerNameController.text,
        workerField: workerFieldController.text,
        workerPhoneNumber: workerPhoneNumberController.text,
        workerEmail: workerEmailController.text,
        workerLocation: workerLocationController.text,
        workingHours: workingHoursController.text,
        pendingRequests: [],
        recommendationList: [],
        acceptedupcomingRequests: [],
        pastRequests: [],
      );

      Map<String, dynamic> data = newWorker.toJson();

      await FirebaseFirestore.instance.collection('workers').add(data);

      print('Worker data added to Firestore.');
    } catch (e) {
      print('Error adding worker data: $e');
    }
  }
}

Stream<List<Worker>> _getWorkerDataStream() async* {
  List<Worker> workers = [];
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection("WorkerData").get();
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      workers.add(Worker.fromJson(data));
    });

    yield workers;
  } catch (e) {
    print(e);
  }
}

class NewDashboardWorker extends StatefulWidget {
  @override
  _NewDashboardWorkerState createState() => _NewDashboardWorkerState();
}

class _NewDashboardWorkerState extends State<NewDashboardWorker> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Dashboard Worker'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Past Services',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
      body: _buildTabPages(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            label: 'Accepted/Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Pending Requests',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showRecommendationsDialog(context);
        },
        child: Icon(Icons.info),
      ),
    );
  }

  Widget _buildTabPages() {
    switch (_currentIndex) {
      case 0:
        return Center(
          child: Text('Accepted/Upcoming Requests'),
        );
      case 1:
        return Center(
          child: Text('Pending Requests'),
        );
      default:
        return Container();
    }
  }

  void _showRecommendationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Recommendations'),
          content: Text('Add content with recommendations here'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'usersignup.dart';

class WorkerSignupPage extends StatefulWidget {
  @override
  _WorkerSignupPageState createState() => _WorkerSignupPageState();
}

class _WorkerSignupPageState extends State<WorkerSignupPage> {
  String selectedFieldOfWork = 'Welding';
  late TimeOfDay selectedStartTime;
  late TimeOfDay selectedEndTime;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController areaOfWorkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedStartTime = TimeOfDay.now();
    selectedEndTime = _addDurationToTime(selectedStartTime, Duration(hours: 1));
  }

  TimeOfDay _addDurationToTime(TimeOfDay time, Duration duration) {
    int minutes = time.hour * 60 + time.minute + duration.inMinutes;
    return TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Worker Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name *'),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedFieldOfWork,
              onChanged: (newValue) {
                setState(() {
                  selectedFieldOfWork = newValue!;
                });
              },
              items: <String>['Welding', 'Painting', 'Plumbing']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Field of Work *',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number *'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextField(
              controller: areaOfWorkController,
              decoration: InputDecoration(labelText: 'Area of Work *'),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('Working Hours *'),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectStartTime(context),
                    child: Text(
                      selectedStartTime.format(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Text('to'),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectEndTime(context),
                    child: Text(
                      selectedEndTime.format(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_validateFields()) {
                  await _saveDataToFirestore();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewDashboardWorker(),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Validation Error'),
                        content: Text('Please fill in all required fields.'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateFields() {
    return nameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        areaOfWorkController.text.isNotEmpty &&
        selectedFieldOfWork.isNotEmpty &&
        selectedStartTime != null &&
        selectedEndTime != null;
  }

  Future<void> _saveDataToFirestore() async {
    try {
      await FirebaseFirestore.instance.collection("WorkerData").add({
        'name': nameController.text,
        'fieldOfWork': selectedFieldOfWork,
        'phoneNumber': phoneNumberController.text,
        'email': emailController.text,
        'areaOfWork': areaOfWorkController.text,
        'workingHours': {
          'startTime': selectedStartTime.format(context),
          'endTime': selectedEndTime.format(context),
        },
      });
    } catch (exception) {
      print("Error Saving Data to Firestore: $exception");
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    ))!;
    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    ))!;
    if (picked != null && picked != selectedEndTime) {
      setState(() {
        selectedEndTime = picked;
      });
    }
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
      drawer: _buildDrawer(),
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

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Past Services',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                _buildSamplePastServices(),
              ],
            ),
          ),
          ListTile(
            title: Text('Edit Worker Profile'),
            onTap: () {
              _showEditProfilePopup(context);
            },
          ),
          ListTile(
            title: Text('Help'),
            onTap: () {
              _showHelpPopup(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSamplePastServices() {
    // Replace this with your actual past services data
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date: mm/dd/yyyy, Time: hh:mm, Area of Work: Plumbing'),
        Text('Date: mm/dd/yyyy, Time: hh:mm, Area of Work: Painting'),
        Text('Date: mm/dd/yyyy, Time: hh:mm, Area of Work: Welding'),
      ],
    );
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

  void _showEditProfilePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Worker Profile'),
          content: Text('Add form fields to edit profile data here'),
          actions: [
            TextButton(
              onPressed: () {
                // Add logic to update data on Firebase
                Navigator.pop(context);
              },
              child: Text('Edit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showHelpPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Help'),
          content: Text('Please call... for help'),
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

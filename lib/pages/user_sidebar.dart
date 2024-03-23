import 'package:flutter/material.dart';

class WorkerDetails extends StatelessWidget {
  String userName = "John Doe";
  String phoneNumber = "123-456-7890";
  String homeAddress = "123 Main St, City";
  bool _isInitialTimePicker = true;

  WorkerDetails({Key? key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddServicePopup(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Scrollbar(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Edit User Profile'),
                onTap: () {
                  Navigator.pop(context);
                  _showEditProfilePopup(context);
                },
              ),
              const Divider(),
              ListTile(
                title: Row(
                  children: [
                    const Text('Help'),
                    const SizedBox(width: 5),
                    IconButton(
                      icon: const Icon(Icons.info),
                      onPressed: () {
                        _showHelpPopup(context);
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              const Text(
                'Past Services Requested',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text('Service #$index'),
                        subtitle: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Time: 12:00 PM'),
                            Text('Date: 2024-01-01'),
                          ],
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                tabs: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Accepted/Upcoming Requests',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Pending Requests',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('Accepted/Upcoming Requests Content')),
                  Center(child: Text('Pending Requests Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddServicePopup(BuildContext context) async {
    TimeOfDay? selectedTime;

    if (_isInitialTimePicker) {
      selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      _isInitialTimePicker = false;
    } else {
      selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
    }

    if (selectedTime != null) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Add Service',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const Text('Service Field'),
                DropdownButton<String>(
                  items:
                      ["Welding", "Painting", "Plumbing"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {},
                ),
                const SizedBox(height: 16),
                const Text('Time of Service'),
                ElevatedButton(
                  onPressed: () async {
                    selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  },
                  child: const Text('Pick Time'),
                ),
                const SizedBox(height: 16),
                const Text('Location'),
                const TextField(
                  decoration: InputDecoration(hintText: 'Enter location'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Add Service'),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void _showEditProfilePopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Edit User Profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text('Name'),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: userName),
                onChanged: (value) {
                  userName = value;
                },
              ),
              const SizedBox(height: 16),
              const Text('Phone #'),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: phoneNumber),
                onChanged: (value) {
                  phoneNumber = value;
                },
              ),
              const SizedBox(height: 16),
              const Text('Home Address'),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your home address',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: homeAddress),
                onChanged: (value) {
                  homeAddress = value;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Update Profile'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _handleLogOut(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,//if any problem in log out button just know that this line will have to be changed to primary
                ),
                child: const Text('Log Out'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showHelpPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Help'),
          content:
              const Text('Please contact 123456789 if any help is needed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _handleLogOut(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      '/',
    );
  }
}

import 'package:flutter/material.dart';

import 'otpverificationpage.dart';

class WorkerBox extends StatefulWidget {
  final String workerName;
  final String workerField;
  final String phoneNumber;
  final String recommender;

  const WorkerBox({
    Key? key,
    required this.workerName,
    required this.workerField,
    required this.phoneNumber,
    required this.recommender,
  }) : super(key: key);

  @override
  _WorkerBoxState createState() => _WorkerBoxState();
}

class _WorkerBoxState extends State<WorkerBox> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text(widget.workerName),
            subtitle: Text(widget.workerField),
            trailing: IconButton(
              icon: Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Worker Name: ${widget.workerName}'),
                  Text('Worker Field: ${widget.workerField}'),
                  Text('Phone Number: ${widget.phoneNumber}'),
                  Text('Recommender: ${widget.recommender}'),
                  ElevatedButton(
                    onPressed: () {
                      _showDetailsPopup(context);
                    },
                    child: const Text('View Details'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showDetailsPopup(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Worker Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Worker Name: ${widget.workerName}'),
              Text('Worker Field: ${widget.workerField}'),
              Text('Phone Number: ${widget.phoneNumber}'),
              const Text('Work Location: TBD'),
              const Text('Work Hours: TBD'),
              Text('Shop Owner: ${widget.recommender}'),
              const Text('Shop Name: TBD'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: OTPVerificationPage(phoneNumber: '123-456-7890'),
    ),
  );
}

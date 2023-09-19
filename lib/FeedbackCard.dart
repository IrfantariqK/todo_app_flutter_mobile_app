import 'package:flutter/material.dart';

class FeedbackCard extends StatefulWidget {
  final Map<String, dynamic> feedback;
  final VoidCallback onDeleteClick;
  final VoidCallback onUpdateClick;

  FeedbackCard({
    required this.feedback,
    required this.onDeleteClick,
    required this.onUpdateClick,
  });

  @override
  _FeedbackCardState createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  bool expanded = false;

  void toggleExpand() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.feedback['name'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(widget.feedback['title']),
              ],
            ),
          ),
          InkWell(
            onTap: toggleExpand,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      widget.feedback['image'],
                      width: 100, // Reduced image width
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: widget.onDeleteClick,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                        child: Text('Delete'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: widget.onUpdateClick,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                        child: Text('Update'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: toggleExpand, // Toggle expand on button press
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            expanded ? Colors.grey : Colors.green, // Change button color based on expand state
                          ),
                        ),
                        child: Text(expanded ? 'Close' : 'Open'), // Change button text based on expand state
                      ),
                    ],
                  ),
                  if (expanded)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Age: ${widget.feedback['age']}'),
                        Text('Email: ${widget.feedback['email']}'),
                        Text('Feedback: ${widget.feedback['feedback']}'),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

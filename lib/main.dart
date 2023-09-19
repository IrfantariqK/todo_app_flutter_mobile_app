import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class FeedbackData {
  final int id;
  final String name;
  final String title;
  final String image;
  final int age;
  final String feedback;
  final String email;

  FeedbackData({
    required this.id,
    required this.name,
    required this.title,
    required this.image,
    required this.age,
    required this.feedback,
    required this.email,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<FeedbackData> feedbackData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.4.240:8080/api/feedback'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<FeedbackData> fetchedData = data.map((item) => FeedbackData(
          id: item['id'],
          name: item['name'],
          title: item['title'],
          image: item['image'],
          age: int.parse(item['age']),
          feedback: item['feedback'],
          email: item['email'],
        )).toList();

        setState(() {
          feedbackData = fetchedData;
        });
      } else {
        throw Exception('Failed to load feedback data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Cards'),
        actions: [
          // Add a "Refresh" button to the AppBar
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              fetchData(); // Call fetchData when the button is pressed
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: feedbackData.length,
        itemBuilder: (context, index) {
          return FeedbackCard(feedback: feedbackData[index]);
        },
      ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  final FeedbackData feedback;

  FeedbackCard({required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(feedback.image),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feedback.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(feedback.title),
                Text('Age: ${feedback.age.toString()}'),
                Text('Email: ${feedback.email}'),
                Text('Feedback: ${feedback.feedback}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

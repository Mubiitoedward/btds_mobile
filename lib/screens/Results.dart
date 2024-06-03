import 'package:btds_mobile/Auth/Authentication.dart';
import 'package:btds_mobile/functions/connection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final AuthenticationFunctions authFunctions = AuthenticationFunctions(); // Create an instance of AuthenticationFunctions
  List<Map<String, dynamic>> results = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  Future<void> fetchResults() async {
    String? userIdString = await authFunctions.getuerid(); // Get the user ID as a string
    if (userIdString != null) {
      int userid = int.parse(userIdString); // Convert the user ID to an integer
      final response = await http.post(
        Uri.parse(API.get_results),
        body: {'userid': userid.toString()},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json. decode(response.body);
        if (jsonResponse['saved'] == 'success') {
          setState(() {
            results = List<Map<String, dynamic>>.from(jsonResponse['results']);
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonResponse['message']),
          ));
        }
      } else {
        setState(() {
          isLoading = false;
        });
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to load results'),
        ));
      }
    } else {
      setState(() {
        isLoading = false;
      });
      // Handle error: user not logged in
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User not logged in'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Results'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : results.isEmpty
              ? Center(child: Text('No results found'))
              : ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final result = results[index];
                    return ListTile(
                      title: Text(result['label']),
                      subtitle: Text(
                          'Confidence: ${result['confidence']}%\nDate: ${result['recorded_at']}'),
                    );
                  },
                ),
    );
  }
}

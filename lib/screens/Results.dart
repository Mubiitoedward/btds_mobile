import 'dart:io';

import 'package:btds_mobile/Auth/Authentication.dart';
import 'package:btds_mobile/functions/connection.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final AuthenticationFunctions authFunctions =
      AuthenticationFunctions(); // Create an instance of AuthenticationFunctions
  List<Map<String, dynamic>> results = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  Future<void> fetchResults() async {
    String? userId =
        await authFunctions.getuerid(); // Get the user ID as a string
    print(userId);
    if (userId != null) {
      var response = await http.post(
        Uri.parse(API.get_results),
        body: {'userid': userId},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['saved'] == 'success') {
          print(results);
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


  Future<void> downloadResults() async {
    // Generate CSV
    List<List<dynamic>> rows = [];
    rows.add(["Label", "Confidence", "Date"]); // Header row

    for (var result in results) {
      List<dynamic> row = [];
      row.add(result["label"]);
      row.add(result["confidence"].toString());
      row.add(result["created_at"]);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    // Get the directory to save the file
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/results.csv";

    // Write the CSV to a file
    final file = File(path);
    await file.writeAsString(csv);

    // Display a message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Results downloaded: $path'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Result Records'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : results.isEmpty
              ? Center(child: Text('No records found'))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
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
                  ),
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: downloadResults,
                        child: Text('Download Results'),
                      ),
                    ),
                ],
              ),
    );
  }
}

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
  final AuthenticationFunctions authFunctions = AuthenticationFunctions();
  List<Map<String, dynamic>> results = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  Future<void> fetchResults() async {
    String? userId = await authFunctions.getuerid();
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
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonResponse['message']),
          ));
        }
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to load results'),
        ));
      }
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User not logged in'),
      ));
    }
  }

  Future<void> downloadResults() async {
    List<List<dynamic>> rows = [];
    rows.add(["Label", "Confidence", "Date"]); 

    for (var result in results) {
      List<dynamic> row = [];
      row.add(result["label"]);
      row.add(result["confidence"].toString());
      row.add(result["created_at"]);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/results.csv";

    final file = File(path);
    await file.writeAsString(csv);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Results downloaded: $path'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Result Records', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : results.isEmpty
              ? Center(child: Text('No records found', style: TextStyle(fontSize: 18)))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final result = results[index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(result['label'], style: TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4),
                                    Text('Confidence: ${result['confidence']}%', style: TextStyle(color: Colors.grey[600])),
                                    Text('Date: ${result['recorded_at']}', style: TextStyle(color: Colors.grey[600])),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: downloadResults,
                        icon: Icon(Icons.download),
                        label: Text('Download Results'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          iconColor   : Colors.black,
                          textStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

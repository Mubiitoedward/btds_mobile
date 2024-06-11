import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'results_controller.dart';

class ResultsPage extends StatelessWidget {
  final ResultsController resultsController = Get.put(ResultsController());

  ResultsPage({Key? key}) : super(key: key);

  Future<void> downloadResults() async {
    List<List<dynamic>> rows = [];
    rows.add(["Label", "Confidence", "Date"]); 

    for (var result in resultsController.results) {
      List<dynamic> row = [];
      row.add(result["label"]);
      row.add(result["confidence"].toString());
      row.add(result["recorded_at"]);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/results.csv";

    final file = File(path);
    await file.writeAsString(csv);

    Get.snackbar('Download Complete', 'Results downloaded to: $path');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Result Records', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        if (resultsController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (resultsController.results.isEmpty) {
          return Center(child: Text('No records found', style: TextStyle(fontSize: 18)));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: resultsController.results.length,
                    itemBuilder: (context, index) {
                      final result = resultsController.results[index];
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
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: "Image",
                                    content: Image.network(result['image_url']),
                                  );
                                },
                                child: Text('View Image'),
                              ),
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
                    iconColor: Colors.black,
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
 
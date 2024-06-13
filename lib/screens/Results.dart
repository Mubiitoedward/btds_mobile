import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  Future<List<dynamic>> fetchResults() async {
    final response =
        await Supabase.instance.client.from('Patients_Reg').select();

    if (response!= null) {
      throw Exception(response);
    }

    return response as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Results'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No results found'));
          }

          final results = snapshot.data!;
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return ListTile(
                title: Text(result['Full_name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Gender: ${result['Gender']}'),
                    Text('Age: ${result['Age']}'),
                    Text('Phone Number: ${result['Telephone_Number']}'),
                    Text('Address: ${result['Address']}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

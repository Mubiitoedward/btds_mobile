import 'package:btds_mobile/data/drawerss.dart';
import 'package:btds_mobile/data/my_colors.dart';
import 'package:btds_mobile/screens/results_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'dart:io';
import 'dart:developer' as devtools;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

class Diagonise extends StatefulWidget {
  const Diagonise({Key? key}) : super(key: key);

  @override
  State<Diagonise> createState() => _DiagoniseState();
}

class _DiagoniseState extends State<Diagonise> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final ResultsController resultsController = Get.put(ResultsController());

  File? filePath;
  String label = ' ';
  double confidence = 0.0;

  Future<void> _tFliteInit() async {
    String? res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false
    );
  }

  pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image == null) return;

    var imageMap = File(image.path);
    setState(() {
      filePath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true
    );

    if (recognitions == null) {
      devtools.log("recognitions are null");
      return;
    }
    devtools.log(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = recognitions[0]['label'].toString();
    });
  }

  Future<void> saveResultToStorage(String label, double confidence) async {
    try {
      // Create a CSV file with label and confidence
      List<List<dynamic>> rows = [
        ["Label", "Confidence"],
        [label, confidence.toString()]
      ];
      String csv = const ListToCsvConverter().convert(rows);

      // Get the directory to save the CSV file
      final directory = await getApplicationDocumentsDirectory();
      final path = "${directory.path}/result.csv";

      // Write the CSV file
      final file = File(path);
      await file.writeAsString(csv);

      // Upload the CSV file to Firebase Storage
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final storageRef = FirebaseStorage.instance.ref().child('users/${user.uid}/results.csv');
        await storageRef.putFile(file);

        Get.snackbar('Success', 'Result saved to Firebase Storage successfully');
      } else {
        Get.snackbar('Error', 'User not logged in');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save result to Firebase Storage');
    }
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState();
    _tFliteInit();
  }

List<Map<String, dynamic>> promos = [
    {
      'promo': 'Get your results instantly generated',
      'image': 'assets/images/ActiveHumanBrain.png'
    },
    {
      'promo': 'Get your brain image diagonised in just a click',
      'image': 'assets/images/human-brain.png'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
        title: Text("DIAGNOSIS PAGE", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: Mydrawer(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.only(bottom: 15, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Notifications',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: CarouselSlider(
                          items: promos.map((item) => Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          item['promo'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  Image.asset(item['image'], scale: 6)
                                ],
                              ),
                            ),
                          )).toList(),
                          options: CarouselOptions(
                              height: 200,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              autoPlayInterval: Duration(seconds: 3),
                              viewportFraction: 0.8)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                children: [
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage('assets/images/brain-1.png'),
                      ),
                    ),
                    child: filePath == null
                        ? Text('')
                        : Image.file(filePath!, fit: BoxFit.fill),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "The Accuracy is ${confidence.toStringAsFixed(0)}%",
                          style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: () => pickImage(ImageSource.camera),
                          child: Text('Camera', style: TextStyle(color: MyColors.accent)),
                        ),
                        TextButton(
                          onPressed: () => pickImage(ImageSource.gallery),
                          child: Text('Gallery', style: TextStyle(color: MyColors.accent)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        resultsController.saveResult(label, confidence);
                        saveResultToStorage(label, confidence);
                      },
                      child: Text('Save Result'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

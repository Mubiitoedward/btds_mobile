import 'dart:convert';

import 'package:btds_mobile/data/drawerss.dart';
import 'package:btds_mobile/snackbar.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:btds_mobile/data/my_colors.dart';
import 'package:http/http.dart' as http;

import 'dart:io';

import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as devtools;
import 'package:supabase/supabase.dart';

class Diagonise extends StatefulWidget {
  const Diagonise({Key? key}) : super(key: key);

  @override
  State<Diagonise> createState() => _DiagoniseState();
}

class _DiagoniseState extends State<Diagonise> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();


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

  File? filePath;
  String label = ' ';
  double confidence = 0.0;
  final snackbar = Snackbar();
  bool _isLoading = false;
  bool results = false;

  // Supabase client initialization
  final SupabaseClient supabaseClient = SupabaseClient(
    'https://nfxmgafcnppcpgbjkmyd.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5meG1nYWZjbnBwY3BnYmprbXlkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY1NjM5NDUsImV4cCI6MjAzMjEzOTk0NX0._pSJi7n-ktaSmzE_lL_aTkUlu-2YjB9hd7CDsnMN_8A',
  );

  Future<void> _tFliteInit() async {
    String? res = await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1, // defaults to 1
      isAsset:
          true, // defaults to true, set to false to load resources outside assets
      useGpuDelegate:
          false, // defaults to false, set to true to use GPU delegate
    );
  }

  Future<void> storeResults(
      String userId, String label, double confidence) async {
    try {
      final response = await supabaseClient.from('resultsdb').insert({
        'userid': userId,
        'label': label,
        'confidence': confidence,
      });
      // .execute();

      if (response.error == null) {
        devtools.log('Data stored successfully in Supabase');
      } else {
        devtools.log(
            'Failed to store data in Supabase: ${response.error!.message}');
      }
    } catch (e) {
      devtools.log('Error storing data: $e');
      snackbar.displaymessage(context, 'An Error occurred', false);
    }
  }

  pickImagecamera() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    var imageMap = File(image.path);
    setState(() {
      filePath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    if (recognitions == null) {
      return;
      devtools.log("recognitions are null");
    }
    devtools.log(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = recognitions[0]['label'].toString();
    });
  }

  pickImageGallery() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    var imageMap = File(image.path);
    setState(() {
      filePath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    if (recognitions == null) {
      return;
      devtools.log("recognitions are null");
    }
    devtools.log(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = recognitions[0]['label'].toString();
    });
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

  Future<String?> getCurrentUserId() async {
    final user = supabaseClient.auth.currentUser;
    return user?.id;
  }

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
        title: Text("B T D S", style: TextStyle(color: Colors.white)),
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
            Container(
              height: 200,
            ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                transform: Matrix4.translationValues(0.0, -35.0, 0.0),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Container(
                          color: Color.fromARGB(255, 154, 153, 151),
                          padding: EdgeInsets.only(bottom: 15, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Notifications',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                child: CarouselSlider(
                                    items: promos
                                        .map(
                                          (item) => Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 5),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      // crossAxisAlignment:
                                                      //     CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          item['promo'],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Image.asset(
                                                    item['image'],
                                                    scale: 6,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    options: CarouselOptions(
                                        height: 200,
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        aspectRatio: 16 / 9,
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enableInfiniteScroll: true,
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 800),
                                        autoPlayInterval: Duration(seconds: 3),
                                        viewportFraction: 0.8)),
                              ),
                            ],
                          ),
                        )),
                    Container(
                      height: 20,
                    ),
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
                      image: const DecorationImage(
                        image: AssetImage('assets/images/brain-1.png'),
                      ),
                    ),
                    child: filePath == null
                        ? const Text('')
                        : Image.file(
                            filePath!,
                            fit: BoxFit.fill,
                          ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[800],
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        Text(
                          "The Accuracy is ${confidence.toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[800],
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.transparent),
                          onPressed: () {
                            pickImagecamera();
                          },
                          child: Text(
                            'Camera',
                            style: TextStyle(color: MyColors.accent),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.transparent),
                          onPressed: () {
                            pickImageGallery();
                          },
                          child: Text(
                            'Gallery',
                            style: TextStyle(color: MyColors.accent),
                          ),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String? userId =
                          await getCurrentUserId(); // Get the user ID
                      if (userId != null) {
                        await storeResults(userId, label, confidence);
                      } else {
                        devtools.log('User not logged in');
                      }
                    },
                    child: Text('Save Results'),
                  ),
                  Container(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
          ]
      )));
  }
}

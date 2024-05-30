
import 'package:btds_mobile/data/drawerss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:btds_mobile/data/my_colors.dart';
import 'package:flutter/widgets.dart';


import 'dart:io';

import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as devtools;

class Diagonise extends StatefulWidget {
  const Diagonise({Key? key}) : super(key: key);

  @override
  State<Diagonise> createState() => _DiagoniseState();
}

class _DiagoniseState extends State<Diagonise> {
 GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  File? filePath;
  String label = ' ';
  double confidence = 0.0;

  Future<void> _tFliteInit() async {
    String? res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.grey[400],
      key: scaffoldKey,
      appBar: new AppBar(
         backgroundColor: Colors.black,
        
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
        title: new Text("B T D S", style: TextStyle(color: Colors.white)),
                leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.close),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   )
        // ],
      ),
      drawer: Mydrawer(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 200,
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
                    //   Image.asset(
                    //   Img.get('brain-1.png'),

                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          // "The Accuracy is ${confidence.toStringAsFixed(0)}%",
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
                          // "The Accuracy is ${confidence.toStringAsFixed(0)}%",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

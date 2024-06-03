import 'package:btds_mobile/data/my_colors.dart';
import 'package:btds_mobile/data/my_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/img.dart';

class Stories extends StatelessWidget {
  const Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 55,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: new Text("Frequently Asked Questions", style: TextStyle(color: Colors.white)),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.close),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Column(
      children: [
        Image.asset(
          Img.get('brain-x-ray.png'),
          width: double.infinity,
          height: 140,
          fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'What is the Brain Tumor Detection System for Glioma Diagnosis?',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[800],
                ),
              ),
              Container(
                height: 10,
              ),
              Container(
                child: Text(MyStrings.medium_lorem_ipsum,
                    style: TextStyle(fontSize: 15, color: Colors.grey[600])),
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.transparent),
              onPressed: () {},
              child: Text(
                'Share',
                style: TextStyle(color: MyColors.accent),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.transparent),
              onPressed: () {},
              child: Text(
                'Explore',
                style: TextStyle(color: MyColors.accent),
              ),
            )
          ],
        ),
        Container(
          height: 5,
        )
      ],
    ),
  ),
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
        Image.asset(
          Img.get('ActiveHumanBrain.png'),
          width: double.infinity,
          height: 140,
          fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'How does the system work?',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[800],
                ),
              ),
              Container(
                height: 10,
              ),
              Container(
                child: Text(MyStrings.middle_lorem_ipsum,
                    style: TextStyle(fontSize: 15, color: Colors.grey[600])),
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.transparent),
              onPressed: () {},
              child: Text(
                'Share',
                style: TextStyle(color: MyColors.accent),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.transparent),
              onPressed: () {},
              child: Text(
                'Explore',
                style: TextStyle(color: MyColors.accent),
              ),
            )
          ],
        ),
        Container(
          height: 5,
        )
      ],
    ),
  ),
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
        Image.asset(
          Img.get('seeking-solutions-in-the-human-brain.png'),
          width: double.infinity,
          height: 140,
          fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Who can use the system?',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[800],
                ),
              ),
              Container(
                height: 10,
              ),
              Container(
                child: Text(MyStrings.long_lorem_ipsum,
                    style: TextStyle(fontSize: 15, color: Colors.grey[600])),
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.transparent),
              onPressed: () {},
              child: Text(
                'Share',
                style: TextStyle(color: MyColors.accent),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.transparent),
              onPressed: () {},
              child: Text(
                'Explore',
                style: TextStyle(color: MyColors.accent),
              ),
            )
          ],
        ),
        Container(
          height: 5,
        )
      ],
    ),
  ),
    Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Column(
      children: [
        Image.asset(
          Img.get('human-brain.png'),
          width: double.infinity,
          height: 140,
          fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Is the system easy to use?',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[800],
                ),
              ),
              Container(
                height: 10,
              ),
              Container(
                child: Text(MyStrings.long_lorem_ipsum_2,
                    style: TextStyle(fontSize: 15, color: Colors.grey[600])),
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.transparent),
              onPressed: () {},
              child: Text(
                'Share',
                style: TextStyle(color: MyColors.accent),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.transparent),
              onPressed: () {},
              child: Text(
                'Explore',
                style: TextStyle(color: MyColors.accent),
              ),
            )
          ],
        ),
        Container(
          height: 5,
        )
      ],
    ),
  ),
   
   Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Column(
      children: [
        Image.asset(
          Img.get('brain-activity-image.png'),
          width: double.infinity,
          height: 140,
          fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Can the system be integrated into existing healthcare IT infrastructure?',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[800],
                ),
              ),
              Container(
                height: 10,
              ),
              Container(
                child: Text(MyStrings.short_lorem_ipsum,
                    style: TextStyle(fontSize: 15, color: Colors.grey[600])),
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.transparent),
              onPressed: () {},
              child: Text(
                'Share',
                style: TextStyle(color: MyColors.accent),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.transparent),
              onPressed: () {},
              child: Text(
                'Explore',
                style: TextStyle(color: MyColors.accent),
              ),
            )
          ],
        ),
        Container(
          height: 5,
        )
      ],
    ),
  ),
          ],
        ),
      ),
    );
  }
}


  


  


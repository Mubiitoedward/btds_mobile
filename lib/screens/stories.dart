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
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: new Text("Basic Card", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Card1(),
            Container(
              height: 20,
            ),
            Card1(),
            Container(
              height: 20,
            ),
            Card1(),
          ],
        ),
      ),
    );
  }
}

Card1() {
  return Card(
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
                'Hello there, we are hereto greet you in all capacities',
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
  );
}

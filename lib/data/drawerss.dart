
import 'package:btds_mobile/Auth/login.dart';
import 'package:btds_mobile/Darshboard/Diagonise.dart';
import 'package:btds_mobile/data/img.dart';
import 'package:btds_mobile/screens/Results.dart';
import 'package:btds_mobile/screens/registerPatient.dart';
import 'package:btds_mobile/screens/stories.dart';
import 'package:btds_mobile/widget/my_text.dart';
import 'package:flutter/material.dart';

Drawer Mydrawer(BuildContext context) {
  // UserDetails userdetails = Get.put(UserDetails());
  return Drawer(
    child: Stack(
      children: [
        Image.asset(
          Img.get(
            'drawer-bg.jpg',
          ),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.5),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
            ),
            Row(
              children: [
                Container(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Spacer(),
              ],
            ),
            Container(
              height: 30,
            ),
            Image.asset(
              Img.get('BT2-01.png'),
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              color: Colors.white,
            ),
            Container(
              height: 10,
            ),
            Text(
              "BTDS",
              style: MyText.headline(context)!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 40,
            ),
            Divider(
              color: Colors.white,
              height: 1,
            ),
            InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Diagonise()));
            },
            child: ListTile(
              leading: Icon(Icons.logout_sharp, color: Colors.white),
              title: Text(
                "Diagonise",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
            Container(
              height: 10,
            ),
        InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPatient()));
            },
            child: ListTile(
              leading: Icon(Icons.logout_sharp, color: Colors.white),
              title: Text(
                "Patient Reg",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
            Container(
              height: 10,
            ),
             InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Results()));
            },
            child: ListTile(
              leading: Icon(Icons.logout_sharp, color: Colors.white),
              title: Text(
                "Results",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
            Container(
              height: 10,
            ),
             InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Stories()));
            },
            child: ListTile(
              leading: Icon(Icons.question_answer, color: Colors.white),
              title: Text(
                "FAQs",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
            Container(
              height: 10,
            ),
            Divider(
              color: Colors.white,
              height: 1,
            ),
            Spacer(),
             InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()));
            },
            child: ListTile(
              leading: Icon(Icons.logout_sharp, color: Colors.white),
              title: Text(
                "LogOut",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ],
        )
      ],
    ),
  );
}

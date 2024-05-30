import 'package:btds_mobile/data/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class RegisterPatient extends StatefulWidget {
  RegisterPatient();

  @override
  RegisterPatientState createState() => RegisterPatientState();
}

class RegisterPatientState extends State<RegisterPatient> {
  TextStyle textStyle = TextStyle(
      color: Colors.pink[800], fontSize: 16, fontWeight: FontWeight.bold);
  TextStyle labelstyle = TextStyle(color: Colors.pink[800]);
  UnderlineInputBorder lineStyle1 = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.pink[800]!, width: 2));
  UnderlineInputBorder lineStyle2 = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.pink[800]!, width: 2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.pink[800],
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.pink[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 230,
              width: double.infinity,
              color: MyColors.grey_10,
              child: Stack(
                children: [
                  Center(
                      child: Icon(
                    Icons.person,
                    size: 220,
                    color: Colors.white,
                  )),
                  Container(
                    transform: Matrix4.translationValues(0.0, 40.0, 0.0),
                    margin: EdgeInsets.all(15),
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      heroTag: "Fab3",
                      backgroundColor: Colors.blueGrey[800],
                      elevation: 3,
                      child: Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    style: textStyle,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.pink[800],
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.person,
                          color: Colors.pink[800],
                        ),
                      ),
                      labelText: "Name",
                      labelStyle: labelstyle,
                      enabledBorder: lineStyle1,
                      focusedBorder: lineStyle2,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          style: textStyle,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.pink[800],
                          decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.phone,
                                color: Colors.pink[800],
                              ),
                            ),
                            labelText: "Phone Number",
                            labelStyle: labelstyle,
                            enabledBorder: lineStyle1,
                            focusedBorder: lineStyle2,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          style: textStyle,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.pink[800],
                          decoration: InputDecoration(
                            suffixIcon: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.pink[800],
                              ),
                            ),
                            labelText: "Type",
                            labelStyle: labelstyle,
                            enabledBorder: lineStyle1,
                            focusedBorder: lineStyle2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          style: textStyle,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.pink[800],
                          decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.email,
                                color: Colors.pink[800],
                              ),
                            ),
                            labelText: " Email",
                            labelStyle: labelstyle,
                            enabledBorder: lineStyle1,
                            focusedBorder: lineStyle2,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          style: textStyle,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.pink[800],
                          decoration: InputDecoration(
                            suffixIcon: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.pink[800],
                              ),
                            ),
                            labelText: "Type",
                            labelStyle: labelstyle,
                            enabledBorder: lineStyle1,
                            focusedBorder: lineStyle2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: textStyle,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.pink[800],
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.home,
                          color: Colors.pink[800],
                        ),
                      ),
                      labelText: "Address",
                      labelStyle: labelstyle,
                      enabledBorder: lineStyle1,
                      focusedBorder: lineStyle2,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: textStyle,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.pink[800],
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.build_circle_outlined,
                          color: Colors.pink[800],
                        ),
                      ),
                      labelText: "Company",
                      labelStyle: labelstyle,
                      enabledBorder: lineStyle1,
                      focusedBorder: lineStyle2,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: textStyle,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.pink[800],
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.work,
                          color: Colors.pink[800],
                        ),
                      ),
                      labelText: "Job Title",
                      labelStyle: labelstyle,
                      enabledBorder: lineStyle1,
                      focusedBorder: lineStyle2,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: textStyle,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.pink[800],
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.location_city,
                          color: Colors.pink[800],
                        ),
                      ),
                      labelText: "City",
                      labelStyle: labelstyle,
                      enabledBorder: lineStyle1,
                      focusedBorder: lineStyle2,
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

import 'package:btds_mobile/Auth/login.dart';
import 'package:btds_mobile/Darshboard/Diagonise.dart';
import 'package:btds_mobile/Settings/settingsPage.dart';
import 'package:btds_mobile/data/drawerss.dart';
import 'package:btds_mobile/data/img.dart';
import 'package:btds_mobile/screens/AboutSystem.dart';
import 'package:btds_mobile/screens/Results.dart';
import 'package:btds_mobile/screens/registerPatient.dart';
import 'package:btds_mobile/screens/stories.dart';
import 'package:btds_mobile/widget/my_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

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
      key: scaffoldKey,
      backgroundColor: Colors.blue,
      appBar: new AppBar(
        elevation: 0,
        toolbarHeight: 55,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: new Text("Main Dashboard",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.close),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   )
        // ],
      ),
     
      body: Container(
        color: Colors.grey[100],
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    color: Colors.blue,
                    width: double.infinity,
                    height: 140,
                    child: Image.asset(
                      Img.get('world_map.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 10,
                            ),
                            Text('Hello There, ',
                                style: MyText.title(context)!
                                    .copyWith(color: Colors.white)),
                            Container(
                              height: 5,
                            ),
                            Text('Welcome back',
                                style: MyText.medium(context)!
                                    .copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          scaffoldKey.currentState!.openDrawer();
                          
                        },
                      ),
                    ],
                  )
                ],
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
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      color: Colors.white,
                      elevation: 2,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                        height: 250,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 7,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    FloatingActionButton(
                                      heroTag: "fab1",
                                      elevation: 2,
                                      mini: true,
                                      backgroundColor: Colors.red[500],
                                      onPressed: () {
                                        Get.to(() => Stories());
                                      },
                                      child: Icon(Icons.question_mark),
                                    ),
                                    Container(
                                      height: 5,
                                    ),
                                    Text(
                                      'FAQs',
                                      style: MyText.medium(context)!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    FloatingActionButton(
                                      heroTag: "fab2",
                                      elevation: 2,
                                      mini: true,
                                      backgroundColor: Colors.yellow[500],
                                      onPressed: () {
                                        Get.to(() => Diagonise());
                                      },
                                      child: Icon(Icons.medical_services),
                                    ),
                                    Container(
                                      height: 5,
                                    ),
                                    Text(
                                      'Diagnosis',
                                      style: MyText.medium(context)!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    FloatingActionButton(
                                      heroTag: "fab3",
                                      elevation: 2,
                                      mini: true,
                                      backgroundColor: Colors.purple[500],
                                      onPressed: () {
                                        Get.to(() => Aboutsystem());
                                      },
                                      child: Icon(Icons.app_registration),
                                    ),
                                    Container(
                                      height: 5,
                                    ),
                                    Text(
                                      'About',
                                      style: MyText.medium(context)!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    FloatingActionButton(
                                      heroTag: "fab1",
                                      elevation: 2,
                                      mini: true,
                                      backgroundColor: Colors.lightGreen[500],
                                      onPressed: () {
                                        Get.to(() => ResultsPage());
                                      },
                                      child: Icon(Icons.document_scanner),
                                    ),
                                    Container(
                                      height: 5,
                                    ),
                                    Text(
                                      'Results',
                                      style: MyText.medium(context)!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    FloatingActionButton(
                                      heroTag: "fab5",
                                      elevation: 2,
                                      mini: true,
                                      backgroundColor: Colors.pink[500],
                                      onPressed: () {
                                        Get.to(() => SettingsPage());
                                      },
                                      child: Icon(Icons.settings),
                                    ),
                                    Container(
                                      height: 5,
                                    ),
                                    Text(
                                      'settings',
                                      style: MyText.medium(context)!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    FloatingActionButton(
                                      heroTag: "fab6",
                                      elevation: 2,
                                      mini: true,
                                      backgroundColor: Colors.orange[500],
                                      onPressed: () {
                                        Get.to(() => LogInPage());
                                      },
                                      child: Icon(Icons.logout_outlined),
                                    ),
                                    Container(
                                      height: 5,
                                    ),
                                    Text(
                                      'LogOut',
                                      style: MyText.medium(context)!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Container(
                            //   height: 20,
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

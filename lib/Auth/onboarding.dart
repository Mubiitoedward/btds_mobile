import 'package:btds_mobile/Auth/login.dart';
import 'package:btds_mobile/data/img.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widget/my_text.dart';

class FirstPage extends StatefulWidget {
const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LogInPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromARGB(255, 9, 9, 9),
          alignment: Alignment.center,
          child: Stack(children: [
            Container(
             child:Image.asset(
              Img.get('BTLogo-01.png'),
                //color: Colors.red[400],
                width: 150,
                height: 120,
              ),
              alignment: Alignment.center,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "from",
                    style: MyText.body2(context)!.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  Text(
                    "Group26",
                    style: MyText.body1(context)!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              alignment: Alignment.bottomCenter,
            )
          ]),
        ));
  }
}

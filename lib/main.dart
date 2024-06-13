import 'package:btds_mobile/Auth/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'data/my_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Supabase.initialize(
    url: 'https://nfxmgafcnppcpgbjkmyd.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5meG1nYWZjbnBwY3BnYmprbXlkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY1NjM5NDUsImV4cCI6MjAzMjEzOTk0NX0._pSJi7n-ktaSmzE_lL_aTkUlu-2YjB9hd7CDsnMN_8A',
  );
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: MyColors.primary,
          primaryColorDark: MyColors.primaryDark,
          primaryColorLight: MyColors.primaryLight,
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.transparent)),
      home: FirstPage(),
      routes: <String, WidgetBuilder>{
        '/MenuRoute': (BuildContext context) => new FirstPage(),
      }));
}

import 'package:btds_mobile/Settings/AccountSettingsPage.dart';
import 'package:btds_mobile/screens/AboutSystem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var isDarkMode = false.obs;
  var isNotificationsEnabled = true.obs;

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
      isDarkMode.value ? ThemeData.dark() : ThemeData.light(),
    );
  }

  void toggleNotifications() {
    isNotificationsEnabled.value = !isNotificationsEnabled.value;
  }
}

class SettingsPage extends StatelessWidget {
  final SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Obx(() => SwitchListTile(
                title: Text('Dark Mode'),
                value: settingsController.isDarkMode.value,
                onChanged: (value) => settingsController.toggleDarkMode(),
              )),
          Obx(() => SwitchListTile(
                title: Text('Enable Notifications'),
                value: settingsController.isNotificationsEnabled.value,
                onChanged: (value) => settingsController.toggleNotifications(),
              )),
          ListTile(
            title: Text('Account'),
            subtitle: Text('Manage your account settings'),
            trailing: Icon(Icons.arrow_forward),
          onTap: () {
  Get.to(AccountSettingsPage());
},

          ),
          ListTile(
            title: Text('Privacy'),
            subtitle: Text('Manage your privacy settings'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to privacy settings page
            },
          ),
          ListTile(
            title: Text('Help & Support'),
            subtitle: Text('Get help and support'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to help and support page
            },
          ),
          ListTile(
            title: Text('About'),
            subtitle: Text('Learn more about the app'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Get.to(Aboutsystem());
            },
          ),
        ],
      ),
    );
  }
}

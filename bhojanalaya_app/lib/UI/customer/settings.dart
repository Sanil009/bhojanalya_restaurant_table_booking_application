import 'package:bhojanalaya_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Settings'),
        ),
        body: buildSettingsList(),
      ),
    );
  }

  Widget buildSettingsList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
      child: SettingsList(
        sections: [
          SettingsSection(
            titleTextStyle: kSettingsTitleTextStyle,
            title: 'General',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onPressed: (context) {},
              ),
              SettingsTile(
                title: 'Theme',
                subtitle: 'Dark',
                leading: Icon(Icons.cloud_queue),
              ),
            ],
          ),
          SettingsSection(
            titleTextStyle: kSettingsTitleTextStyle,
            title: 'Account',
            tiles: [
              SettingsTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/profile', (route) => false);
                },
                title: 'Account Details',
                leading: Icon(Icons.account_circle_outlined),
              ),
              SettingsTile(
                title: 'Sign out',
                leading: Icon(Icons.exit_to_app),
              ),
            ],
          ),
          // SettingsSection(
          //   titleTextStyle: kSettingsTitleTextStyle,
          //   title: 'Notifications',
          //   tiles: [
          //     SettingsTile.switchTile(
          //       title: 'Lock app in background',
          //       leading: Icon(Icons.phonelink_lock),
          //       switchValue: lockInBackground,
          //       onToggle: (bool value) {
          //         setState(() {
          //           lockInBackground = value;
          //           notificationsEnabled = value;
          //         });
          //       },
          //     ),
          //     SettingsTile.switchTile(
          //       title: 'Enable Notifications',
          //       leading: Icon(Icons.notifications_active),
          //       switchValue: notificationsEnabled,
          //       onToggle: (bool value) {
          //         setState(() {
          //           notificationsEnabled = value;
          //         });
          //       },
          //     ),
          //   ],
          // ),
          SettingsSection(
            titleTextStyle: kSettingsTitleTextStyle,
            title: 'Misc',
            tiles: [
              SettingsTile(
                  title: 'User Manual', leading: Icon(Icons.description)),
              SettingsTile(
                  title: 'Terms and Policies',
                  leading: Icon(Icons.collections_bookmark)),
            ],
          ),
          CustomSection(
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 22, bottom: 8),
                //   child: Image.asset(
                //     'assets/settings.png',
                //     height: 50,
                //     width: 50,
                //     color: Color(0xFF777777),
                //   ),
                // ),
                Text(
                  'Version: 1.0.0',
                  style: TextStyle(color: Color(0xFFD3D3D3)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

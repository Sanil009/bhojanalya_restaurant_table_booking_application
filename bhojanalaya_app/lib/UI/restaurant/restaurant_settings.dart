import 'package:bhojanalaya_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class RestaurantSettingsPage extends StatefulWidget {
  @override
  _RestaurantSettingsPageState createState() => _RestaurantSettingsPageState();
}

class _RestaurantSettingsPageState extends State<RestaurantSettingsPage> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/restaurant_dashboard', (route) => false);
            },
          ),
          elevation: 0,
          title: Text(
            'Settings',
            style: kTextStyle,
          ),
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
                // onTap: () {

                // },
                title: 'Account Details',
                leading: Icon(Icons.account_circle_outlined),
              ),
              SettingsTile(
                title: 'Sign out',
                leading: Icon(Icons.exit_to_app),
              ),
            ],
          ),
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

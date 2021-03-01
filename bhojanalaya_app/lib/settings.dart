import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: ListView(
                // Removing padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    title: Text('Bookings', style: kSmallTextStyle),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Bookings', style: kSmallTextStyle),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Wish lists', style: kSmallTextStyle),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Help Centre', style: kSmallTextStyle),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text('Settings', style: kSmallTextStyle),
                    onTap: () {
                      Navigator.of(context).pushNamed('/settings');
                      //Navigator.pop(context);
                    },
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

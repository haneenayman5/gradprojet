import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/drawer_appBar.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/drawer_listile_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 25, top: 30, bottom: 30),
      child: Column(
        children: [
          DrawerAppbar(),
          DrawerListileItem(
              icon: Icon(
                FontAwesomeIcons.key,
                color: Colors.white,
                size: 22,
              ),
              title: 'Account'),
          DrawerListileItem(
              icon: Icon(Icons.forum_rounded, color: Colors.white, size: 25),
              title: 'Chats'),
          DrawerListileItem(
              icon: Icon(Icons.notifications_active_rounded,
                  color: Colors.white, size: 25),
              title: 'Notifications'),
          DrawerListileItem(
              icon: Icon(FontAwesomeIcons.database,
                  color: Colors.white, size: 22),
              title: 'Data and Storage'),
          DrawerListileItem(
              icon: Icon(FontAwesomeIcons.solidCircleQuestion,
                  color: Colors.white, size: 22),
              title: 'Help'),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 30),
            child: Divider(
              color: kPrimarycolor,
              thickness: 2,
            ),
          ),
          DrawerListileItem(
              icon: Icon(Icons.people_outline_rounded,
                  color: Colors.white, size: 25),
              title: 'invite a friend'),
          Spacer(
            flex: 2,
          ),
          DrawerListileItem(
              icon: RotatedBox(
                  quarterTurns: 2,
                  child: Icon(Icons.exit_to_app_rounded,
                      color: Colors.white, size: 25)),
              title: 'Log Out'),
        ],
      ),
    );
  }
}

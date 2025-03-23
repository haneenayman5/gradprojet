import 'package:flutter/material.dart';
import 'package:untitled3/core/util/styles.dart';
import 'package:untitled3/core/util/widgets/custom_iconButton.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chat With \nfriends',
            style: Styles.textStyle30.copyWith(color: Colors.white),
          ),
          CustomIconButton(
            icon: Icons.menu_rounded,
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
    );
  }
}

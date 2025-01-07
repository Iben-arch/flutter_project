import 'package:flutter/material.dart';
import 'package:modern_profile/constant/constant.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 40,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: bgSecondaryColor,
            child: Icon(
              Icons.settings,
              size: 24,
              color: iconPrimaryColor,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            'Setting',
            style: textSubTitle,
          ),
          const SizedBox(
            width: 15,
          ),
          const CircleAvatar(
            radius: 16,
            backgroundColor: bgSecondaryColor,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: iconSecondaryColor,
            ),
          )
        ],
      ),
    );
  }
}

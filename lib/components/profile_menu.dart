// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:modern_profile/constant/constant.dart';

class ProfileMenu extends StatelessWidget {
  final String title;
  final IconData icons;
  const ProfileMenu({
    Key? key,
    required this.title,
    required this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 40,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: bgSecondaryColor,
            child: Icon(
              icons,
              size: 24,
              color: iconPrimaryColor,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: textSubTitle,
          ),
          const SizedBox(
            width: 15,
          ),
          const Spacer(),
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

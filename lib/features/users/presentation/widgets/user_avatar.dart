import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseelatask/core/theming/colors.dart';

class UserAvatar extends StatelessWidget {
  final String avatarUrl;
  final double radius;

  const UserAvatar({super.key, required this.avatarUrl, this.radius = 60});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius.r,
      backgroundImage: NetworkImage(avatarUrl),
      backgroundColor: ColorsManager.lightGray,
    );
  }
}

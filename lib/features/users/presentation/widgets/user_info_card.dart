import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseelatask/core/helpers/spacing.dart';
import 'package:waseelatask/core/theming/colors.dart';
import 'package:waseelatask/core/theming/styles.dart';

class UserInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const UserInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorsManager.bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: ColorsManager.mainBlue, size: 24.sp),
          horizontalSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyles.font13GrayRegular),
                verticalSpace(4),
                Text(value, style: TextStyles.font16BlackSemiBold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

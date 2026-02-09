import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseelatask/core/helpers/app_texts.dart';
import 'package:waseelatask/core/helpers/spacing.dart';
import 'package:waseelatask/core/theming/colors.dart';
import 'package:waseelatask/core/theming/styles.dart';

class UserDetailsErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const UserDetailsErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.sp, color: ColorsManager.gray),
          verticalSpace(16),
          Text(message, style: TextStyles.font14GrayRegular),
          verticalSpace(16),
          ElevatedButton(onPressed: onRetry, child: Text(AppTexts.retry)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseelatask/core/helpers/app_texts.dart';
import 'package:waseelatask/core/helpers/spacing.dart';
import 'package:waseelatask/core/theming/styles.dart';
import 'package:waseelatask/core/widgets/app_text_button.dart';
import 'package:waseelatask/features/users/domain/entities/user_entity.dart';
import 'package:waseelatask/features/users/presentation/widgets/user_info_card.dart';

class UserDetailsViewMode extends StatelessWidget {
  final UserEntity user;
  final VoidCallback onEditPressed;

  const UserDetailsViewMode({
    super.key,
    required this.user,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserInfoCard(
          icon: Icons.person,
          label: AppTexts.fullName,
          value: user.fullName,
        ),
        verticalSpace(16),
        UserInfoCard(
          icon: Icons.email,
          label: AppTexts.email,
          value: user.email,
        ),
        verticalSpace(16),
        UserInfoCard(
          icon: Icons.badge,
          label: AppTexts.userId,
          value: '#${user.id}',
        ),
        verticalSpace(32),
        AppTextButton(
          buttonText: AppTexts.editUser,
          onPressed: onEditPressed,
          buttonHeight: 40.h,
          textStyle: TextStyles.font18DarkGreyBold.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

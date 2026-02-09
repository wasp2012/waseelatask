import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseelatask/core/helpers/app_texts.dart';
import 'package:waseelatask/core/helpers/spacing.dart';
import 'package:waseelatask/core/theming/styles.dart';
import 'package:waseelatask/core/widgets/app_text_button.dart';
import 'package:waseelatask/core/widgets/app_text_form_field.dart';

class UserDetailsEditMode extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController jobController;
  final VoidCallback onSave;
  final bool isLoading;

  const UserDetailsEditMode({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.jobController,
    required this.onSave,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppTexts.name, style: TextStyles.font14DarkBlueMedium),
          verticalSpace(8),
          AppTextFormField(
            controller: nameController,
            hintText: AppTexts.enterName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.nameRequired;
              }
              return null;
            },
          ),
          verticalSpace(20),
          Text(AppTexts.job, style: TextStyles.font14DarkBlueMedium),
          verticalSpace(8),
          AppTextFormField(
            controller: jobController,
            hintText: AppTexts.enterJobTitle,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppTexts.jobRequired;
              }
              return null;
            },
          ),
          verticalSpace(32),
          AppTextButton(
            buttonText: AppTexts.saveChanges,
            buttonHeight: 40.h,
            textStyle: TextStyles.font18DarkGreyBold.copyWith(
              color: Colors.white,
            ),
            onPressed: onSave,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}

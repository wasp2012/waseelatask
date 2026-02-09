import 'dart:developer';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:waseelatask/core/helpers/extensions.dart';
import 'package:waseelatask/core/theming/styles.dart';
import 'package:waseelatask/core/widgets/app_text_button.dart';

void showLoadingDialog(BuildContext context) {
  log('Called showLoadingDialog');
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: Image.asset(
        'assets/gifs/loading-gif.gif',
        height: 50.0,
        width: 50.0,
      ),
    ),
  );
}

void showSuccessDialog(BuildContext context,
    {required String titleText,
    String? bodyText,
    required Function() onPressed}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: const Color(0xfff4f4f4),
        title: Center(child: Text(titleText)),
        content: bodyText != null && bodyText.isNotEmpty
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  bodyText,
                  style: const TextStyle(color: Colors.black),
                ),
              )
            : const SizedBox.shrink(),
        actions: <Widget>[
          AppTextButton(
              horizontalPadding: 0,
              verticalPadding: 0,
              buttonHeight: 5,
              buttonText: 'Success',
              backgroundColor: const Color.fromARGB(255, 56, 160, 60),
              textStyle: TextStyles.font16BlackSemiBold,
              onPressed: () {
                onPressed();
              }),
        ],
      );
    },
  );
}

void showErrorDialog(BuildContext context, String error,
    {bool isPop = false,
    Function()? onPressed,
    String? buttonText,
    bool? isWithCancelButton}) {
  if (isPop) {
    context.pop();
  }
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: const Color(0xfff4f4f4),
      icon: const Icon(
        Icons.error,
        color: Colors.red,
        size: 32,
      ),
      content: Text(
        error,
        style: TextStyles.font15DarkBlueMedium,
        textAlign: TextAlign.center,
      ),
      actions: [
        AppTextButton(
          horizontalPadding: 0,
          verticalPadding: 0,
          buttonHeight: 5,
          buttonText: buttonText ?? 'Cancel',
          backgroundColor: const Color.fromARGB(255, 204, 55, 45),
          textStyle:
              TextStyles.font16BlackSemiBold.copyWith(color: Colors.white),
          onPressed: () {
            if (onPressed != null) {
              onPressed();
            }
            context.pop();
          },
        ),
        if (isWithCancelButton != null && isWithCancelButton == true)
          AppTextButton(
            horizontalPadding: 0,
            verticalPadding: 0,
            buttonHeight: 5,
            buttonText: 'Cancel',
            backgroundColor: const Color.fromARGB(255, 204, 55, 45),
            textStyle:
                TextStyles.font16BlackSemiBold.copyWith(color: Colors.white),
            onPressed: () {
              context.pop();
            },
          ),
      ],
    ),
  );
}

void showSnackBar(BuildContext context, String message, bool isError,
    {Function()? onTap}) {
  showTopSnackBar(
    onTap: onTap,
    Overlay.of(context),
    isError
        ? CustomSnackBar.error(
            message: message,
            textStyle: TextStyle(fontSize: 20.sp, color: Colors.white),
          )
        : CustomSnackBar.success(
            message: message,
            textStyle: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
  );
}


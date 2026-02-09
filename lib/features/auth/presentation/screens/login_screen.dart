import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseelatask/core/helpers/app_regex.dart';
import 'package:waseelatask/core/helpers/app_texts.dart';
import 'package:waseelatask/core/helpers/extensions.dart';
import 'package:waseelatask/core/helpers/spacing.dart';
import 'package:waseelatask/core/routing/routes.dart';
import 'package:waseelatask/core/theming/colors.dart';
import 'package:waseelatask/core/theming/styles.dart';
import 'package:waseelatask/core/widgets/app_text_button.dart';
import 'package:waseelatask/core/widgets/app_text_form_field.dart';
import 'package:waseelatask/features/auth/presentation/cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      await context.read<AuthCubit>().login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.pushReplacementNamed(Routes.usersList);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  verticalSpace(80),
                  // Logo/Title
                  Icon(
                    Icons.people_alt_rounded,
                    size: 80.sp,
                    color: ColorsManager.mainBlue,
                  ),
                  verticalSpace(16),
                  Text(
                    AppTexts.welcomeBack,
                    style: TextStyles.font24BlueBold,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(8),
                  Text(
                    AppTexts.signInToContinue,
                    style: TextStyles.font14GrayRegular,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(48),

                  // Email Field
                  Text(AppTexts.email, style: TextStyles.font14DarkBlueMedium),
                  verticalSpace(8),
                  AppTextFormField(
                    controller: _emailController,
                    hintText: AppTexts.enterYourEmail,
                    keyboard: TextInputType.emailAddress,
                    validator: (email) {
                      return AppRegex.isEmailValid(email ?? '')
                          ? null
                          : AppTexts.invalidEmail;
                    },
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  verticalSpace(20),

                  // Password Field
                  Text(
                    AppTexts.password,
                    style: TextStyles.font14DarkBlueMedium,
                  ),
                  verticalSpace(8),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) =>
                        current is AuthPasswordVisibilityChanged ||
                        current is AuthInitial,
                    builder: (context, state) {
                      final isVisible = context
                          .read<AuthCubit>()
                          .isPasswordVisible;
                      return AppTextFormField(
                        controller: _passwordController,
                        hintText: AppTexts.enterYourPassword,
                        isObscureText: !isVisible,
                        validator: (password) {
                          return password != null && password.isNotEmpty
                              ? null
                              : AppTexts.invalidPassword;
                        },
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isVisible ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            context
                                .read<AuthCubit>()
                                .togglePasswordVisibility();
                          },
                        ),
                      );
                    },
                  ),
                  verticalSpace(32),

                  // Login Button
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) =>
                        current is AuthLoading ||
                        current is AuthSuccess ||
                        current is AuthError ||
                        current is AuthInitial,
                    builder: (context, state) {
                      return AppTextButton(
                        buttonHeight: 40.h,
                        buttonText: AppTexts.login,
                        textStyle: TextStyles.font18DarkGreyBold.copyWith(
                          color: Colors.white,
                        ),
                        onPressed: _onLoginPressed,
                        isLoading: state is AuthLoading,
                      );
                    },
                  ),
                  verticalSpace(24),

                  // Test credentials hint
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: ColorsManager.bgColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      children: [
                        Text(
                          AppTexts.testCredentials,
                          style: TextStyles.font14DarkBlueMedium,
                        ),
                        verticalSpace(4),
                        Text(
                          AppTexts.testEmail,
                          style: TextStyles.font13GrayRegular,
                        ),
                        Text(
                          AppTexts.testPassword,
                          style: TextStyles.font13GrayRegular,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

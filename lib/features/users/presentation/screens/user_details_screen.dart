import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseelatask/core/helpers/app_texts.dart';
import 'package:waseelatask/core/helpers/spacing.dart';
import 'package:waseelatask/core/theming/colors.dart';
import 'package:waseelatask/core/theming/styles.dart';
import 'package:waseelatask/core/widgets/app_text_button.dart';
import 'package:waseelatask/core/widgets/app_text_form_field.dart';
import 'package:waseelatask/features/users/presentation/cubit/user_details_cubit.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;

  const UserDetailsScreen({super.key, required this.userId});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _jobController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    final cubit = context.read<UserDetailsCubit>();
    final user = cubit.user;
    if (user != null && !cubit.isEditing) {
      _nameController.text = user.fullName;
      _jobController.text = '';
    }
    cubit.toggleEditing();
  }

  Future<void> _onSave() async {
    if (_formKey.currentState!.validate()) {
      await context.read<UserDetailsCubit>().updateUser(
        widget.userId,
        _nameController.text.trim(),
        _jobController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var userDetailsCubit = context.read<UserDetailsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.userDetails, style: TextStyles.font16WhiteMedium),
        backgroundColor: ColorsManager.mainBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          BlocBuilder<UserDetailsCubit, UserDetailsState>(
            buildWhen: (previous, current) =>
                current is UserDetailsEditingChanged ||
                current is UserDetailsLoaded ||
                current is UserDetailsUpdated,
            builder: (context, state) {
              final isEditing = userDetailsCubit.isEditing;
              return IconButton(
                icon: Icon(isEditing ? Icons.close : Icons.edit),
                color: Colors.white,
                onPressed: _toggleEdit,
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<UserDetailsCubit, UserDetailsState>(
        listener: (context, state) {
          if (state is UserDetailsUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppTexts.userUpdatedSuccessfully),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is UserDetailsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is UserDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserDetailsError &&
              userDetailsCubit.user == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64.sp,
                    color: ColorsManager.gray,
                  ),
                  verticalSpace(16),
                  Text(state.message, style: TextStyles.font14GrayRegular),
                  verticalSpace(16),
                  ElevatedButton(
                    onPressed: () async => await context
                        .read<UserDetailsCubit>()
                        .loadUser(widget.userId),
                    child: Text(AppTexts.retry),
                  ),
                ],
              ),
            );
          }

          final user = userDetailsCubit.user;
          if (user == null) return const SizedBox.shrink();

          final isEditing = userDetailsCubit.isEditing;

          return SingleChildScrollView(
            padding: EdgeInsets.all(24.r),
            child: Column(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 60.r,
                  backgroundImage: NetworkImage(user.avatar),
                  backgroundColor: ColorsManager.lightGray,
                ),
                verticalSpace(24),

                if (!isEditing) ...[
                  // Display Mode
                  _buildInfoCard(
                    icon: Icons.person,
                    label: AppTexts.fullName,
                    value: user.fullName,
                  ),
                  verticalSpace(16),
                  _buildInfoCard(
                    icon: Icons.email,
                    label: AppTexts.email,
                    value: user.email,
                  ),
                  verticalSpace(16),
                  _buildInfoCard(
                    icon: Icons.badge,
                    label: AppTexts.userId,
                    value: '#${user.id}',
                  ),
                  verticalSpace(32),
                  AppTextButton(
                    buttonText: AppTexts.editUser,
                    textStyle: TextStyles.font16WhiteMedium,
                    onPressed: _toggleEdit,
                    horizontalPadding: 0,
                    verticalPadding: 16,
                  ),
                ] else ...[
                  // Edit Mode
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppTexts.name,
                          style: TextStyles.font14DarkBlueMedium,
                        ),
                        verticalSpace(8),
                        AppTextFormField(
                          controller: _nameController,
                          hintText: AppTexts.enterName,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppTexts.nameRequired;
                            }
                            return null;
                          },
                        ),
                        verticalSpace(20),
                        Text(
                          AppTexts.job,
                          style: TextStyles.font14DarkBlueMedium,
                        ),
                        verticalSpace(8),
                        AppTextFormField(
                          controller: _jobController,
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
                          textStyle: TextStyles.font16WhiteMedium,
                          onPressed: _onSave,
                          isLoading: state is UserDetailsUpdating,
                          horizontalPadding: 0,
                          verticalPadding: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
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

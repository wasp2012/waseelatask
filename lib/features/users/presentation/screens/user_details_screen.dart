import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseelatask/core/helpers/app_texts.dart';
import 'package:waseelatask/core/helpers/spacing.dart';
import 'package:waseelatask/core/theming/colors.dart';
import 'package:waseelatask/core/theming/styles.dart';
import 'package:waseelatask/features/users/presentation/cubit/user_details_cubit.dart';
import 'package:waseelatask/features/users/presentation/widgets/user_avatar.dart';
import 'package:waseelatask/features/users/presentation/widgets/user_details_edit_mode.dart';
import 'package:waseelatask/features/users/presentation/widgets/user_details_error_widget.dart';
import 'package:waseelatask/features/users/presentation/widgets/user_details_view_mode.dart';

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
    final userDetailsCubit = context.read<UserDetailsCubit>();

    return Scaffold(
      appBar: _buildAppBar(userDetailsCubit),
      body: BlocConsumer<UserDetailsCubit, UserDetailsState>(
        listener: _handleStateChanges,
        builder: (context, state) {
          if (state is UserDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserDetailsError && userDetailsCubit.user == null) {
            return UserDetailsErrorWidget(
              message: state.message,
              onRetry: () =>
                  context.read<UserDetailsCubit>().loadUser(widget.userId),
            );
          }

          final user = userDetailsCubit.user;
          if (user == null) return const SizedBox.shrink();

          final isEditing = userDetailsCubit.isEditing;

          return SingleChildScrollView(
            padding: EdgeInsets.all(24.h),
            child: Column(
              children: [
                UserAvatar(avatarUrl: user.avatar),
                verticalSpace(24),
                if (!isEditing)
                  UserDetailsViewMode(user: user, onEditPressed: _toggleEdit)
                else
                  UserDetailsEditMode(
                    formKey: _formKey,
                    nameController: _nameController,
                    jobController: _jobController,
                    onSave: _onSave,
                    isLoading: state is UserDetailsUpdating,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(UserDetailsCubit userDetailsCubit) {
    return AppBar(
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
    );
  }

  void _handleStateChanges(BuildContext context, UserDetailsState state) {
    if (state is UserDetailsUpdated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppTexts.userUpdatedSuccessfully),
          backgroundColor: Colors.green,
        ),
      );
    } else if (state is UserDetailsError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message), backgroundColor: Colors.red),
      );
    }
  }
}

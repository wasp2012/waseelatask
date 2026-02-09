import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseelatask/core/helpers/app_texts.dart';
import 'package:waseelatask/core/helpers/extensions.dart';
import 'package:waseelatask/core/helpers/spacing.dart';
import 'package:waseelatask/core/routing/routes.dart';
import 'package:waseelatask/core/theming/colors.dart';
import 'package:waseelatask/core/theming/styles.dart';
import 'package:waseelatask/features/users/presentation/cubit/users_cubit.dart';
import 'package:waseelatask/features/users/presentation/widgets/user_card.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onScroll() async {
    if (_isBottom) {
      await context.read<UsersCubit>().loadMore();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.users, style: TextStyles.font16WhiteMedium),
        backgroundColor: ColorsManager.mainBlue,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              context.pushReplacementNamed(Routes.login);
            },
          ),
        ],
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading || state is UsersInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UsersError) {
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
                    onPressed: () async =>
                        await context.read<UsersCubit>().loadUsers(),
                    child: Text(AppTexts.retry),
                  ),
                ],
              ),
            );
          }

          final users = context.read<UsersCubit>().users;
          final isLoadingMore = state is UsersLoadingMore;

          if (users.isEmpty) {
            return Center(
              child: Text(
                AppTexts.noUsers,
                style: TextStyles.font14GrayRegular,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => await context.read<UsersCubit>().refresh(),
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: users.length + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= users.length) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: const CircularProgressIndicator(),
                    ),
                  );
                }

                final user = users[index];
                return UserCard(
                  user: user,
                  onTap: () {
                    context.pushNamed(Routes.userDetails, arguments: user.id);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

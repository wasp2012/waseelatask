import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waseelatask/core/di/dependency_injection.dart';
import 'package:waseelatask/core/routing/routes.dart';
import 'package:waseelatask/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:waseelatask/features/auth/presentation/screens/login_screen.dart';
import 'package:waseelatask/features/users/presentation/cubit/user_details_cubit.dart';
import 'package:waseelatask/features/users/presentation/cubit/users_cubit.dart';
import 'package:waseelatask/features/users/presentation/screens/user_details_screen.dart';
import 'package:waseelatask/features/users/presentation/screens/users_list_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );

      case Routes.usersList:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<UsersCubit>()..loadUsers(),
            child: const UsersListScreen(),
          ),
        );

      case Routes.userDetails:
        final userId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<UserDetailsCubit>()..loadUser(userId),
            child: UserDetailsScreen(userId: userId),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

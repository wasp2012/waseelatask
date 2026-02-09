part of 'users_cubit.dart';

abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoadingMore extends UsersState {
  final List<UserEntity> users;
  UsersLoadingMore({required this.users});
}

class UsersLoaded extends UsersState {
  final List<UserEntity> users;
  final bool hasMore;
  UsersLoaded({required this.users, required this.hasMore});
}

class UsersError extends UsersState {
  final String message;
  UsersError({required this.message});
}

part of 'user_details_cubit.dart';

abstract class UserDetailsState {}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsLoaded extends UserDetailsState {
  final UserEntity user;
  UserDetailsLoaded({required this.user});
}

class UserDetailsEditingChanged extends UserDetailsState {
  final UserEntity user;
  final bool isEditing;
  UserDetailsEditingChanged({required this.user, required this.isEditing});
}

class UserDetailsUpdating extends UserDetailsState {
  final UserEntity user;
  UserDetailsUpdating({required this.user});
}

class UserDetailsUpdated extends UserDetailsState {
  UserDetailsUpdated();
}

class UserDetailsError extends UserDetailsState {
  final String message;
  UserDetailsError({required this.message});
}

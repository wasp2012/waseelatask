import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waseelatask/features/users/domain/entities/user_entity.dart';
import 'package:waseelatask/features/users/domain/usecases/get_user_usecase.dart';
import 'package:waseelatask/features/users/domain/usecases/update_user_usecase.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  final GetUserUseCase getUserUseCase;
  final UpdateUserUseCase updateUserUseCase;

  UserDetailsCubit({
    required this.getUserUseCase,
    required this.updateUserUseCase,
  }) : super(UserDetailsInitial());

  UserEntity? _user;
  UserEntity? get user => _user;

  bool _isEditing = false;
  bool get isEditing => _isEditing;

  void toggleEditing() {
    _isEditing = !_isEditing;
    if (_user != null) {
      emit(UserDetailsEditingChanged(user: _user!, isEditing: _isEditing));
    }
  }

  void cancelEditing() {
    _isEditing = false;
    if (_user != null) {
      emit(UserDetailsEditingChanged(user: _user!, isEditing: _isEditing));
    }
  }

  Future<void> loadUser(int id) async {
    emit(UserDetailsLoading());
    final result = await getUserUseCase(id);
    result.fold((failure) => emit(UserDetailsError(message: failure)), (user) {
      _user = user;
      _isEditing = false;
      emit(UserDetailsLoaded(user: user));
    });
  }

  Future<void> updateUser(int id, String name, String job) async {
    emit(UserDetailsUpdating(user: _user!));

    final result = await updateUserUseCase(id, name, job);
    result.fold(
      (failure) => emit(UserDetailsError(message: failure)),
      (_) => emit(UserDetailsUpdated()),
    );
  }
}

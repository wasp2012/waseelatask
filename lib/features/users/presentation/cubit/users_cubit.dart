import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waseelatask/features/users/domain/entities/user_entity.dart';
import 'package:waseelatask/features/users/domain/usecases/get_users_usecase.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetUsersUseCase getUsersUseCase;

  UsersCubit(this.getUsersUseCase) : super(UsersInitial());

  List<UserEntity> _users = [];
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoadingMore = false;

  List<UserEntity> get users => _users;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  bool get hasMore => _currentPage < _totalPages;

  Future<void> loadUsers() async {
    emit(UsersLoading());
    _currentPage = 1;
    final result = await getUsersUseCase(_currentPage);
    result.fold((failure) => emit(UsersError(message: failure)), (response) {
      _users = response.users;
      _totalPages = response.totalPages;
      emit(UsersLoaded(users: _users, hasMore: response.hasMore));
    });
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !hasMore) return;

    _isLoadingMore = true;
    emit(UsersLoadingMore(users: _users));

    _currentPage++;
    final result = await getUsersUseCase(_currentPage);
    result.fold(
      (failure) {
        _currentPage--;
        emit(UsersLoaded(users: _users, hasMore: hasMore));
      },
      (response) {
        _users = [..._users, ...response.users];
        _totalPages = response.totalPages;
        emit(UsersLoaded(users: _users, hasMore: response.hasMore));
      },
    );
    _isLoadingMore = false;
  }

  Future<void> refresh() async {
    _currentPage = 1;
    final result = await getUsersUseCase(_currentPage);
    result.fold((failure) => emit(UsersError(message: failure)), (response) {
      _users = response.users;
      _totalPages = response.totalPages;
      emit(UsersLoaded(users: _users, hasMore: response.hasMore));
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waseelatask/core/helpers/local_storage_helper.dart';
import 'package:waseelatask/features/auth/domain/usecases/login_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final LocalStorageHelper localStorageHelper;
  AuthCubit(this.loginUseCase, this.localStorageHelper) : super(AuthInitial());

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    emit(AuthPasswordVisibilityChanged(isVisible: _isPasswordVisible));
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await loginUseCase(email, password);
    result.fold((failure) => emit(AuthError(message: failure)), (
      loginEntity,
    ) async {
      await localStorageHelper.saveToken(loginEntity.token);
      emit(AuthSuccess(token: loginEntity.token));
    });
  }
}

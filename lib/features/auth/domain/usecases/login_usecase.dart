import 'package:dartz/dartz.dart';
import 'package:waseelatask/features/auth/domain/entities/login_entity.dart';
import 'package:waseelatask/features/auth/domain/repos/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<String, LoginEntity>> call(String email, String password) {
    return repository.login(email, password);
  }
}

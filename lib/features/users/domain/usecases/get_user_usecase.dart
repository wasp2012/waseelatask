import 'package:dartz/dartz.dart';
import 'package:waseelatask/features/users/domain/entities/user_entity.dart';
import 'package:waseelatask/features/users/domain/repos/users_repository.dart';

class GetUserUseCase {
  final UsersRepository repository;

  GetUserUseCase(this.repository);

  Future<Either<String, UserEntity>> call(int id) {
    return repository.getUser(id);
  }
}

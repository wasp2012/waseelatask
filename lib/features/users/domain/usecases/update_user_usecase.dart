import 'package:dartz/dartz.dart';
import 'package:waseelatask/features/users/domain/repos/users_repository.dart';

class UpdateUserUseCase {
  final UsersRepository repository;

  UpdateUserUseCase(this.repository);

  Future<Either<String, void>> call(int id, String name, String job) {
    return repository.updateUser(id, name, job);
  }
}

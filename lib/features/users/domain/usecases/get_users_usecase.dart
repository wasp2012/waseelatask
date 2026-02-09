import 'package:dartz/dartz.dart';
import 'package:waseelatask/features/users/domain/entities/users_response_entity.dart';
import 'package:waseelatask/features/users/domain/repos/users_repository.dart';

class GetUsersUseCase {
  final UsersRepository repository;

  GetUsersUseCase(this.repository);

  Future<Either<String, UsersResponseEntity>> call(int page) {
    return repository.getUsers(page);
  }
}

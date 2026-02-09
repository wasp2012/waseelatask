import 'package:dartz/dartz.dart';
import 'package:waseelatask/features/users/domain/entities/user_entity.dart';
import 'package:waseelatask/features/users/domain/entities/users_response_entity.dart';

abstract class UsersRepository {
  Future<Either<String, UsersResponseEntity>> getUsers(int page);
  Future<Either<String, UserEntity>> getUser(int id);
  Future<Either<String, void>> updateUser(int id, String name, String job);
}

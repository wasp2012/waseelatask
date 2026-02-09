import 'package:dartz/dartz.dart';
import 'package:waseelatask/core/helpers/app_texts.dart';
import 'package:waseelatask/core/networking/api_error_handler.dart';
import 'package:waseelatask/features/users/data/datasource/users_remote_datasource.dart';
import 'package:waseelatask/features/users/data/models/update_user_request_model.dart';
import 'package:waseelatask/features/users/data/models/user_details_response_model.dart';
import 'package:waseelatask/features/users/data/models/users_response_model.dart';
import 'package:waseelatask/features/users/domain/entities/user_entity.dart';
import 'package:waseelatask/features/users/domain/entities/users_response_entity.dart';
import 'package:waseelatask/features/users/domain/repos/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;

  UsersRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, UsersResponseEntity>> getUsers(int page) async {
    try {
      final response = await remoteDataSource.getUsers(page);
      final usersResponse = UsersResponseModel.fromJson(response.data);
      return right(
        UsersResponseEntity(
          users: usersResponse.users.map((e) => e.toEntity()).toList(),
          page: usersResponse.page,
          perPage: usersResponse.perPage,
          total: usersResponse.total,
          totalPages: usersResponse.totalPages,
        ),
      );
    } catch (e) {
      return left(
        ErrorHandler.handle(e).failure.error ?? AppTexts.defaultError,
      );
    }
  }

  @override
  Future<Either<String, UserEntity>> getUser(int id) async {
    try {
      final response = await remoteDataSource.getUser(id);
      return right(
        UserDetailsResponseModel.fromJson(response.data).user.toEntity(),
      );
    } catch (e) {
      return left(
        ErrorHandler.handle(e).failure.error ?? AppTexts.defaultError,
      );
    }
  }

  @override
  Future<Either<String, void>> updateUser(
    int id,
    String name,
    String job,
  ) async {
    try {
      final request = UpdateUserRequestModel(name: name, job: job);
      await remoteDataSource.updateUser(id, request);
      return right(null);
    } catch (e) {
      return left(
        ErrorHandler.handle(e).failure.error ?? AppTexts.defaultError,
      );
    }
  }
}

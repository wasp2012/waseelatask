import 'package:dartz/dartz.dart';
import 'package:waseelatask/core/helpers/app_texts.dart';
import 'package:waseelatask/core/networking/api_error_handler.dart';
import 'package:waseelatask/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:waseelatask/features/auth/data/models/login_request_model.dart';
import 'package:waseelatask/features/auth/data/models/login_response_model.dart';
import 'package:waseelatask/features/auth/domain/entities/login_entity.dart';
import 'package:waseelatask/features/auth/domain/repos/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, LoginEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final request = LoginRequestModel(email: email, password: password);
      final response = await remoteDataSource.login(request);
      return right(LoginResponseModel.fromJson(response.data).toEntity());
    } catch (e) {
      return left(
        ErrorHandler.handle(e).failure.error ?? AppTexts.defaultError,
      );
    }
  }
}

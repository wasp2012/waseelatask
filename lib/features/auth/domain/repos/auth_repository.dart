import 'package:dartz/dartz.dart';
import 'package:waseelatask/features/auth/domain/entities/login_entity.dart';

abstract class AuthRepository {
  Future<Either<String, LoginEntity>> login(String email, String password);
}

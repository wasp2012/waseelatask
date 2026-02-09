import 'package:dio/dio.dart';
import 'package:waseelatask/core/networking/api_service.dart';
import 'package:waseelatask/core/networking/api_urls.dart';
import 'package:waseelatask/features/auth/data/models/login_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<Response> login(LoginRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<Response> login(LoginRequestModel request) async {
    final response = await apiService.post(
      endPoint: ApiUrls.login,
      data: request.toJson(),
    );
    return response;
  }
}

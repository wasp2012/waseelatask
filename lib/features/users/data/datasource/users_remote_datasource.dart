import 'package:dio/dio.dart';
import 'package:waseelatask/core/networking/api_service.dart';
import 'package:waseelatask/core/networking/api_urls.dart';
import 'package:waseelatask/features/users/data/models/update_user_request_model.dart';

abstract class UsersRemoteDataSource {
  Future<Response> getUsers(int page);
  Future<Response> getUser(int id);
  Future<void> updateUser(int id, UpdateUserRequestModel request);
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final ApiService apiService;

  UsersRemoteDataSourceImpl(this.apiService);

  @override
  Future<Response> getUsers(int page) async {
    final response = await apiService.get(
      endPoint: ApiUrls.users,
      queryParameters: {'page': page},
    );
    return response;
  }

  @override
  Future<Response> getUser(int id) async {
    final response = await apiService.get(endPoint: ApiUrls.userById(id));
    return response;
  }

  @override
  Future<void> updateUser(int id, UpdateUserRequestModel request) async {
    await apiService.put(
      endPoint: ApiUrls.userById(id),
      data: request.toJson(),
    );
  }
}

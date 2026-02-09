import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(endPoint, queryParameters: queryParameters);
  }

  Future<Response> post({required String endPoint, dynamic data}) async {
    return await dio.post(endPoint, data: data);
  }

  Future<Response> put({required String endPoint, dynamic data}) async {
    return await dio.put(endPoint, data: data);
  }

  Future<Response> delete({required String endPoint}) async {
    return await dio.delete(endPoint);
  }
}

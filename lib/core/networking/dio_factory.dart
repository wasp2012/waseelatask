import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:waseelatask/core/networking/api_urls.dart';

class DioFactory {
  static Dio? dio;

  DioFactory._();

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.baseUrl = ApiUrls.baseUrl
        ..options.headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'x-api-key': dotenv.env['REQRES_API_KEY'] ?? '',
        }
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;

      addDioInterceptor();
    }

    return dio!;
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
      ),
    );
  }
}

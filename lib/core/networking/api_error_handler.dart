// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:waseelatask/core/networking/empty_response.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'api_urls.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ResponseCode {
  ///200
  static const int SUCCESS = 200; // success with data
  ///201
  static const int NO_CONTENT = 201; // success with no data (no content)
  ///400
  static const int BAD_REQUEST = 400; // failure, API rejected request
  ///401
  static const int UNAUTORISED = 401; // failure, user is not authorised
  ///403
  static const int FORBIDDEN = 403; //  failure, API rejected request
  ///500
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  ///404
  static const int NOT_FOUND = 404; // failure, not found
  ///422
  static const int API_LOGIC_ERROR = 422; // API , lOGIC ERROR

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = ApiErrors.ok; // success with data
  static const String NO_CONTENT =
      ApiErrors.ok; // success with no data (no content)
  static const String BAD_REQUEST =
      ApiErrors.badRequestError; // failure, API rejected request
  static const String UNAUTORISED =
      ApiErrors.unauthorizedError; // failure, user is not authorised
  static const String FORBIDDEN =
      ApiErrors.forbiddenError; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      ApiErrors.internalServerError; // failure, crash in server side
  static const String NOT_FOUND =
      ApiErrors.notFoundError; // failure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = ApiErrors.timeoutError;
  static const String CANCEL = ApiErrors.defaultError;
  static const String RECIEVE_TIMEOUT = ApiErrors.timeoutError;
  static const String SEND_TIMEOUT = ApiErrors.timeoutError;
  static const String CACHE_ERROR = ApiErrors.cacheError;
  static const String NO_INTERNET_CONNECTION = ApiErrors.noInternetError;
  static const String DEFAULT = ApiErrors.defaultError;
}

extension DataSourceExtension on DataSource {
  EmptyResponse getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return EmptyResponse(
            status: ResponseCode.SUCCESS,
            message: ResponseMessage.SUCCESS.tr());
      case DataSource.NO_CONTENT:
        return EmptyResponse(
            status: ResponseCode.NO_CONTENT,
            message: ResponseMessage.NO_CONTENT.tr());
      case DataSource.BAD_REQUEST:
        return EmptyResponse(
            status: ResponseCode.BAD_REQUEST,
            message: ResponseMessage.BAD_REQUEST.tr());
      case DataSource.FORBIDDEN:
        return EmptyResponse(
            status: ResponseCode.FORBIDDEN,
            message: ResponseMessage.FORBIDDEN.tr());
      case DataSource.UNAUTORISED:
        return EmptyResponse(
            status: ResponseCode.UNAUTORISED,
            message: ResponseMessage.UNAUTORISED.tr());
      case DataSource.NOT_FOUND:
        return EmptyResponse(
            status: ResponseCode.NOT_FOUND,
            message: ResponseMessage.NOT_FOUND.tr());
      case DataSource.INTERNAL_SERVER_ERROR:
        return EmptyResponse(
            status: ResponseCode.INTERNAL_SERVER_ERROR,
            message: ResponseMessage.INTERNAL_SERVER_ERROR.tr());
      case DataSource.CONNECT_TIMEOUT:
        return EmptyResponse(
            status: ResponseCode.CONNECT_TIMEOUT,
            message: ResponseMessage.CONNECT_TIMEOUT.tr());
      case DataSource.CANCEL:
        return EmptyResponse(
            status: ResponseCode.CANCEL, message: ResponseMessage.CANCEL.tr());
      case DataSource.RECIEVE_TIMEOUT:
        return EmptyResponse(
            status: ResponseCode.RECIEVE_TIMEOUT,
            message: ResponseMessage.RECIEVE_TIMEOUT.tr());
      case DataSource.SEND_TIMEOUT:
        return EmptyResponse(
            status: ResponseCode.SEND_TIMEOUT,
            message: ResponseMessage.SEND_TIMEOUT.tr());
      case DataSource.CACHE_ERROR:
        return EmptyResponse(
            status: ResponseCode.CACHE_ERROR,
            message: ResponseMessage.CACHE_ERROR.tr());
      case DataSource.NO_INTERNET_CONNECTION:
        return EmptyResponse(
            status: ResponseCode.NO_INTERNET_CONNECTION,
            message: ResponseMessage.NO_INTERNET_CONNECTION.tr());
      case DataSource.DEFAULT:
        return EmptyResponse(
            status: ResponseCode.DEFAULT,
            message: ResponseMessage.DEFAULT.tr());
    }
  }
}

EmptyResponse _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return error.response?.data != null
            ? EmptyResponse(
                status: error.response?.statusCode ?? 0,
                error: error.response?.data['error'],
                message: error.response?.data['message'],
                apiError: error.response?.data['status'] != null
                    ? Status.fromJson(error.response?.data['status'])
                    : null,
                data: error.response?.data)
            : EmptyResponse(
                status: error.response?.statusCode ?? 0,
                message: error.response?.statusMessage ?? "");
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    default:
      return DataSource.DEFAULT.getFailure();
  }
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}

class ErrorHandler implements Exception {
  late EmptyResponse failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

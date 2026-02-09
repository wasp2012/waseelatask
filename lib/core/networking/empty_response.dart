class EmptyResponse {
  dynamic data;
  String? message;
  int? status;
  String? error;
  Errors? errors;
  Status? apiError;
  EmptyResponse({
    this.data,
    this.message,
    this.status,
    this.error,
    this.apiError,
  });

  EmptyResponse.fromJson(Map<String, dynamic> json) {
    apiError = json['status'] != null ? Status.fromJson(json['status']) : null;
    data = json['data'];
    message = json['message'];
    status = json['status'];
    error = json['error'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (apiError != null) {
      data['status'] = apiError!.toJson();
    }
    data['data'] = this.data;
    data['message'] = message;
    // data['status'] = status;
    data['error'] = error;
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? password;

  Errors({this.password});

  Errors.fromJson(Map<String, dynamic> json) {
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    return data;
  }
}

class ErrorModel {
  Status? status;

  ErrorModel({this.status, });

  ErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status!.toJson();
    }
    return data;
  }
}

class Status {
  bool? isSuccess;
  String? message;
  int? totalRecordCount;
  String? dataValueType;
  String? operationName;
  int? errorCode;
  String? errorTechnicalDetails;

  Status(
      {this.isSuccess,
      this.message,
      this.totalRecordCount,
      this.dataValueType,
      this.operationName,
      this.errorCode,
      this.errorTechnicalDetails});

  Status.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    totalRecordCount = json['totalRecordCount'];
    dataValueType = json['dataValueType'];
    operationName = json['operationName'];
    errorCode = json['errorCode'];
    errorTechnicalDetails = json['errorTechnicalDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isSuccess'] = isSuccess;
    data['message'] = message;
    data['totalRecordCount'] = totalRecordCount;
    data['dataValueType'] = dataValueType;
    data['operationName'] = operationName;
    data['errorCode'] = errorCode;
    data['errorTechnicalDetails'] = errorTechnicalDetails;
    return data;
  }
}

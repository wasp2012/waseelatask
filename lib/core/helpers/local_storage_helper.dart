import 'package:waseelatask/core/helpers/app_constants.dart';
import 'package:waseelatask/core/helpers/local_storage.dart';

class LocalStorageHelper {
  LocalStorage localStorage;
  LocalStorageHelper(this.localStorage);

  Future<void> saveToken(String token) async {
    await localStorage.writeSecureData(AppConstants.tokenKey, token);
  }

  Future<String> getToken() async {
    return await localStorage.readSecureData(AppConstants.tokenKey);
  }

  Future<void> saveUserId(String userId) async {
    await localStorage.writeSecureData(AppConstants.userId, userId);
  }

  Future<String> getUserId() async {
    return await localStorage.readSecureData(AppConstants.userId);
  }
  Future<void> saveUserMobile(String userMobile) async {
    await localStorage.writeSecureData(AppConstants.userMobile, userMobile);
  }

  Future<String> getUserMobile() async {
    return await localStorage.readSecureData(AppConstants.userMobile);
  }
  Future<void> saveUserName(String userName) async {
    await localStorage.writeSecureData(AppConstants.userName, userName);
  }
  Future<String> getUserName() async {
    return await localStorage.readSecureData(AppConstants.userName);
  }



  Future<void> deleteAllSecureData()async{
    await localStorage.deleteAllSecureData();
  }
}

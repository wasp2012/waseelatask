import 'package:easy_localization/easy_localization.dart';

class AppTexts {
  // Login Screen
  static String get welcomeBack => 'welcome_back'.tr();
  static String get signInToContinue => 'sign_in_to_continue'.tr();
  static String get email => 'email'.tr();
  static String get enterYourEmail => 'enter_your_email'.tr();
  static String get invalidEmail => 'invalid_email'.tr();
  static String get password => 'password'.tr();
  static String get enterYourPassword => 'enter_your_password'.tr();
  static String get invalidPassword => 'invalid_password'.tr();
  static String get login => 'login'.tr();
  static String get testCredentials => 'test_credentials'.tr();
  static String get testEmail => 'test_email'.tr();
  static String get testPassword => 'test_password'.tr();

  // Users List Screen
  static String get users => 'users'.tr();
  static String get retry => 'retry'.tr();
  static String get noUsers => 'no_users'.tr();

  // User Details Screen
  static String get userDetails => 'user_details'.tr();
  static String get fullName => 'full_name'.tr();
  static String get userId => 'user_id'.tr();
  static String get editUser => 'edit_user'.tr();
  static String get name => 'name'.tr();
  static String get enterName => 'enter_name'.tr();
  static String get nameRequired => 'name_required'.tr();
  static String get job => 'job'.tr();
  static String get enterJobTitle => 'enter_job_title'.tr();
  static String get jobRequired => 'job_required'.tr();
  static String get saveChanges => 'save_changes'.tr();
  static String get userUpdatedSuccessfully => 'user_updated_successfully'.tr();

  // Error Messages
  static String get invalidEmailOrPassword => 'invalid_email_or_password'.tr();
  static String get noInternetConnection => 'no_internet_connection'.tr();
  static String get anErrorOccurred => 'an_error_occurred'.tr();
  static String get failedToLoadUsers => 'failed_to_load_users'.tr();
  static String get failedToLoadUserDetails =>
      'failed_to_load_user_details'.tr();
  static String get failedToUpdateUser => 'failed_to_update_user'.tr();
  static String get defaultError => 'default_error'.tr();
}

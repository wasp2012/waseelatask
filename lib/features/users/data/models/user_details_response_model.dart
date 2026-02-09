import 'package:waseelatask/features/users/data/models/user_model.dart';
import 'package:waseelatask/features/users/data/models/users_response_model.dart';

class UserDetailsResponseModel {
  final UserModel user;
  final SupportModel? support;
  final UsersMetaModel? meta;

  UserDetailsResponseModel({required this.user, this.support, this.meta});

  factory UserDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsResponseModel(
      user: UserModel.fromJson(json['data'] ?? {}),
      support: json['support'] != null
          ? SupportModel.fromJson(json['support'])
          : null,
      meta: json['_meta'] != null
          ? UsersMetaModel.fromJson(json['_meta'])
          : null,
    );
  }
}

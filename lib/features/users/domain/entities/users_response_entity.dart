import 'package:waseelatask/features/users/domain/entities/user_entity.dart';

class UsersResponseEntity {
  final List<UserEntity> users;
  final int page;
  final int perPage;
  final int total;
  final int totalPages;

  UsersResponseEntity({
    required this.users,
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
  });

  bool get hasMore => page < totalPages;
}

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:waseelatask/core/helpers/local_storage.dart';
import 'package:waseelatask/core/helpers/local_storage_helper.dart';
import 'package:waseelatask/core/networking/api_service.dart';
import 'package:waseelatask/core/networking/dio_factory.dart';

// Auth
import 'package:waseelatask/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:waseelatask/features/auth/data/repos/auth_repository_impl.dart';
import 'package:waseelatask/features/auth/domain/repos/auth_repository.dart';
import 'package:waseelatask/features/auth/domain/usecases/login_usecase.dart';
import 'package:waseelatask/features/auth/presentation/cubit/auth_cubit.dart';

// Users
import 'package:waseelatask/features/users/data/datasource/users_remote_datasource.dart';
import 'package:waseelatask/features/users/data/repos/users_repository_impl.dart';
import 'package:waseelatask/features/users/domain/repos/users_repository.dart';
import 'package:waseelatask/features/users/domain/usecases/get_user_usecase.dart';
import 'package:waseelatask/features/users/domain/usecases/get_users_usecase.dart';
import 'package:waseelatask/features/users/domain/usecases/update_user_usecase.dart';
import 'package:waseelatask/features/users/presentation/cubit/user_details_cubit.dart';
import 'package:waseelatask/features/users/presentation/cubit/users_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Core
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());
  getIt.registerLazySingleton<LocalStorageHelper>(
    () => LocalStorageHelper(getIt()),
  );
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // Auth
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt(), getIt()));

  // Users
  getIt.registerLazySingleton<UsersRemoteDataSource>(
    () => UsersRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<GetUsersUseCase>(() => GetUsersUseCase(getIt()));
  getIt.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(getIt()));
  getIt.registerLazySingleton<UpdateUserUseCase>(
    () => UpdateUserUseCase(getIt()),
  );
  getIt.registerFactory<UsersCubit>(() => UsersCubit(getIt()));
  getIt.registerFactory<UserDetailsCubit>(
    () => UserDetailsCubit(getUserUseCase: getIt(), updateUserUseCase: getIt()),
  );
}

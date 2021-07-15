import 'package:get_it/get_it.dart';
import 'package:prodia_test/core/base_http_client.dart';
import 'package:prodia_test/core/image_helper.dart';
import 'package:prodia_test/login/data/datasources/remote/login_service.dart';
import 'package:prodia_test/login/data/repositories/login_repository_impl.dart';
import 'package:prodia_test/login/domain/repositories/login_repository.dart';
import 'package:http/http.dart' as http;
import 'package:prodia_test/login/domain/usecases/login_usecase.dart';
import 'package:prodia_test/login/presentation/blocs/login_bloc.dart';
import 'package:prodia_test/main/data/upload_image_repository_impl.dart';
import 'package:prodia_test/main/data/upload_image_service.dart';
import 'package:prodia_test/main/domain/repositories/upload_image_repository.dart';
import 'package:prodia_test/main/domain/usecases/upload_image_usecase.dart';
import 'package:prodia_test/main/presentation/blocs/upload_image_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerLazySingleton<ImageHelper>(() => ImageHelperImpl());
  injector.registerLazySingleton(() => http.Client());
  injector.registerLazySingleton<BaseHttpClient>(
    () => BaseHttpClientImpl(client: injector()),
  );

  injector.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(remoteDataSource: injector()));
  injector.registerLazySingleton<LoginService>(
      () => LoginServiceImpl(client: injector()));
  injector.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(repository: injector()));
  injector.registerFactory<LoginBloc>(
    () => LoginBloc(useCase: injector()),
  );

  injector.registerLazySingleton<UploadImageRepository>(
      () => UploadImageRepositoryImpl(service: injector()));
  injector.registerLazySingleton<UploadImageService>(
      () => UploadImageServiceImpl(client: injector()));
  injector.registerLazySingleton<UploadImageUseCase>(
      () => UploadImageUseCase(repository: injector()));
  injector.registerFactory<UploadImageBloc>(
    () => UploadImageBloc(
      useCase: injector(),
      imageHelper: injector(),
    ),
  );
}

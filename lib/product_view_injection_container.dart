import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/network/network_info.dart';
import 'features/prodouct_management/data/datasources/product_info_remote_datasource.dart';
import 'features/prodouct_management/data/repositories/product_info_repository_impl.dart';
import 'features/prodouct_management/presentation/repositories/product_info_repository.dart';
import 'features/prodouct_management/presentation/viewmodels/product_info_viewmodel.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ViewModel
  sl.registerFactory(() => ProductInfoViewModel(repository: sl()));
  // Repository
  sl.registerLazySingleton<ProductInfoRepository>(
          () => ProductInfoRepositoryImpl(
          remoteDataSource: sl(),
          networkInfo: sl())
  );
  // Data source
  sl.registerLazySingleton<ProductInfoRemoteDataSource>(
          () => ProductInfoRemoteDataSourceImpl(
            client: sl()
          )
  );
  // Core
  sl.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl()
  );
  // External
  sl.registerLazySingleton<Dio>(() => Dio());
}
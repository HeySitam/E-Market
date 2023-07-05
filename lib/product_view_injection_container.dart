import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:goriber_marketplace/features/prodouct_view/data/datasources/product_info_remote_datasource.dart';
import 'package:goriber_marketplace/features/prodouct_view/data/repositories/product_info_repository_impl.dart';
import 'package:goriber_marketplace/features/prodouct_view/presentation/repositories/product_info_repository.dart';
import 'package:goriber_marketplace/features/prodouct_view/presentation/viewmodels/product_info_viewmodel.dart';

import 'core/network/network_info.dart';

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
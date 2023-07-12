import 'package:goriber_marketplace/core/error/failures.dart';
import 'package:goriber_marketplace/core/network/network_failure.dart';

import 'package:goriber_marketplace/core/utils/api_response.dart';



import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../presentation/entities/product_info.dart';
import '../../presentation/repositories/product_info_repository.dart';
import '../datasources/product_info_remote_datasource.dart';

class ProductInfoRepositoryImpl extends ProductInfoRepository{
  final ProductInfoRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductInfoRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<APIResponse<Failure, List<ProductInfo>>> getAllProducts() async {
    APIResponse<Failure, List<ProductInfo>> response = APIResponse();
    if(await networkInfo.isConnected){
      try{
        final allProducts = await remoteDataSource.getAllProducts();
        response.setSuccessResponse(allProducts);
      } on ServerException catch (e, _){
        response.setFailureResponse(ServerFailure(message: e.message));
      }
    } else {
      return response.setFailureResponse(NetworkConnectionFailure());
    }

    return response;
  }

  @override
  Future<APIResponse<Failure, List<ProductInfo>>> getCategoryWiseProducts(String category) async {
    APIResponse<Failure, List<ProductInfo>> response = APIResponse();
    response.startLoading();
    if(await networkInfo.isConnected){
      try{
        final allProducts = await remoteDataSource.getCategoryWiseProducts(category);
        response.setSuccessResponse(allProducts);
      } on ServerException catch (e, _){
        response.setFailureResponse(ServerFailure(message: e.message));
      }
    } else {
      return response.setFailureResponse(NetworkConnectionFailure());
    }

    return response;
  }

  @override
  Future<bool> getNetworkInfo() async {
    bool hasConnection = await networkInfo.isConnected;
    return hasConnection;
  }

}
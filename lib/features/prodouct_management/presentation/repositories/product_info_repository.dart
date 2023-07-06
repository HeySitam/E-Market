import '../../../../core/error/failures.dart';
import '../../../../core/utils/api_response.dart';
import '../entities/product_info.dart';

abstract class ProductInfoRepository {
  Future<APIResponse<Failure, List<ProductInfo>>> getAllProducts();
  Future<APIResponse<Failure, List<ProductInfo>>> getCategoryWiseProducts(String category);
 // Future<APIResponse<Failure, ProductInfo>> getProduct(int productId);
}
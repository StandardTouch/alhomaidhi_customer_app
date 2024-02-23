import 'package:Alhomaidhi/src/features/home/features/product%20details/models/single_product_model.dart';
import 'package:Alhomaidhi/src/features/home/features/product%20details/services/single_product_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDetailsProvider =
    FutureProvider.family<SingleProductModel, String>(
  (ref, productId) async {
    final response = await getProductDetails(productId);
    return response;
  },
);

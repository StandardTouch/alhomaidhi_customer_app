import 'package:alhomaidhi_customer_app/src/features/home/models/brand_response.dart';
import 'package:alhomaidhi_customer_app/src/features/home/services/brands_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final brandsProvider = FutureProvider<BrandResponse>((ref) async {
  final BrandResponse response = await getAllBrands();
  return response;
});

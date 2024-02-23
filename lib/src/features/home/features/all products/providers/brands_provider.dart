import 'package:Alhomaidhi/src/features/home/features/all%20products/models/brand_response.dart';
import 'package:Alhomaidhi/src/features/home/features/all%20products/services/brands_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final brandsProvider = FutureProvider<BrandResponse>((ref) async {
  final BrandResponse response = await getAllBrands();
  return response;
});

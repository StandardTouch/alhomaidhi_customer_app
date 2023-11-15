import 'package:alhomaidhi_customer_app/src/features/home/models/query_model.dart';
import 'package:alhomaidhi_customer_app/src/features/home/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final allProductsQuery = AllProductsQuery(pageNo: 1, search: "", sortBy: "");
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(allProductsProvider(allProductsQuery));
    return products.when(data: (data) {
      if (data.status == "APP00") {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data.message![0].productDetails!.name!),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("An Error Occurred!"),
            Text(data.errorMessage!),
          ],
        );
      }
    }, error: (err, stackTrace) {
      return Center(child: Text("Server Error Occurred: $err"));
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}

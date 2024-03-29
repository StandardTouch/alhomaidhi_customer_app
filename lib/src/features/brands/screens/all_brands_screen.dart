import 'package:Alhomaidhi/src/features/home/features/all%20products/models/brand_response.dart';
import 'package:Alhomaidhi/src/features/home/features/all%20products/providers/brands_provider.dart';
import 'package:Alhomaidhi/src/features/home/features/all%20products/providers/products_provider.dart';
import 'package:Alhomaidhi/src/shared/widgets/refresh_button.dart';
import 'package:Alhomaidhi/src/utils/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AllBrandScreen extends ConsumerStatefulWidget {
  const AllBrandScreen({super.key});

  @override
  ConsumerState<AllBrandScreen> createState() => _AllBrandScreenState();
}

class _AllBrandScreenState extends ConsumerState<AllBrandScreen> {
  void onBrandClick(int newBrandId, String brandName) {
    final query = ref.read(productQueryProvider.notifier);
    query.updateBrand(newBrandId);
    context.pushNamed(
      "brand_products",
      pathParameters: {
        "brandName": brandName,
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(productQueryProvider.notifier).updateSearch("");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final brands = ref.watch(brandsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Brands"),
        forceMaterialTransparency: true,
      ),
      body: brands.when(data: (data) {
        if (data.status == "APP00") {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                // ignore: unused_result
                await ref.refresh(brandsProvider.future);
              },
              child: GridView.builder(
                  itemCount: data.message!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.5,
                  ),
                  padding: const EdgeInsets.all(30),
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      splashColor: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        onBrandClick(
                          data.message![index].id!,
                          data.message![index].name!,
                        );
                      },
                      child: BrandCard(
                        data: data,
                        index: index,
                      ),
                    );
                  }),
            ),
          );
        } else {
          return Center(
            child: Text("An Error Occurred ${data.errorMessage}"),
          );
        }
      }, error: (err, stk) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Server Error Occurred"),
              RefreshButton(provider: brandsProvider)
            ],
          ),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

class BrandCard extends StatelessWidget {
  const BrandCard({super.key, required this.data, required this.index});
  final BrandResponse data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset.fromDirection(360),
              spreadRadius: 2,
              blurRadius: 4),
        ],
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).highlightColor,
      ),
      child: Image.network(
        (data.message![index].img != "")
            ? data.message![index].img ?? Assets.fallBackProductImage
            : Assets.fallBackProductImage,
      ),
    );
  }
}

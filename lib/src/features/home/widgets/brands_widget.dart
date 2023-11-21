import 'package:alhomaidhi_customer_app/src/features/home/providers/brands_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandsWidget extends ConsumerWidget {
  const BrandsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brands = ref.watch(brandsProvider);
    return brands.when(
      data: (data) {
        if (data.status == "APP00") {
          return Container(
            height: 300,
            width: double.infinity,
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10,
                ),
                itemCount: data.message!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(data.message![index].img!),
                        Text(data.message![index].name!),
                      ],
                    ),
                  );
                }),
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
      },
      error: (err, stackTrace) {
        return Center(child: Text("Server Error Occurred: $err"));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

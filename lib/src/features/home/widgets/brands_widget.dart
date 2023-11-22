import 'package:alhomaidhi_customer_app/src/features/home/providers/brands_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandsWidget extends ConsumerWidget {
  const BrandsWidget({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brands = ref.watch(brandsProvider);
    return brands.when(
      data: (data) {
        if (data.status == "APP00") {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(10),
            height: height,
            width: double.infinity,
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 20,
                ),
                itemCount: data.message!.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(data.message![index].img!),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      // add text with brand name below container
                      // Positioned(
                      //   bottom: 0,
                      //   left: 0,
                      //   right: 0,
                      //   child: Text(
                      //     data.message![index].name!,
                      //     textAlign: TextAlign.center,
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .bodyMedium!
                      //         .copyWith(
                      //           color: Colors.white,
                      //         ),
                      //   ),
                      // ),
                      // Image.network(),
                    ],
                  );
                }),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("An Error Occurred!"),
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

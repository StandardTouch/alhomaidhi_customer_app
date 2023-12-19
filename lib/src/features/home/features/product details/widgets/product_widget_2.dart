import 'package:alhomaidhi_customer_app/src/utils/helpers/address_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ProductWidget2 extends ConsumerStatefulWidget {
  const ProductWidget2({
    super.key,
  });

  @override
  ConsumerState<ProductWidget2> createState() => _ProductWidget2State();
}

class _ProductWidget2State extends ConsumerState<ProductWidget2> {
  late Map<String, String>? address;

  void fetchAddress() async {
    address = await getAddressData(ref);
  }

  @override
  void initState() {
    super.initState();
    fetchAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: "Delivered to ",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey,
                          ),
                      children: [
                        TextSpan(
                          text: address?["name"] ?? "No Name provided",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                        ),
                      ]),
                ),
                const Gap(5),
                Text(
                  address?["address"] ?? "No Address Provided",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey,
                      ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Material(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  height: 40,
                  width: 100,
                  child: Text("Change"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

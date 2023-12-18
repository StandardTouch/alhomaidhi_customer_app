import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:intl/intl.dart';

class SingleCartItem extends StatelessWidget {
  const SingleCartItem({
    super.key,
    required this.productImage,
    required this.productName,
    required this.productQuantity,
    required this.itemTotal,
  });
  final String productImage;
  final String productName;
  final int productQuantity;
  final int itemTotal;

  @override
  Widget build(BuildContext context) {
    String getDeliveryDate() {
      DateTime currentDate = DateTime.now();
      DateTime futureDate = currentDate.add(const Duration(days: 5));

      return DateFormat('EEEE MMM dd yyyy').format(futureDate);
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border.fromBorderSide(
          BorderSide(color: Colors.black),
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(productImage),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(productName),
                    ),
                    const Gap(5),
                    // quantity field
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InputQty(
                          initVal: productQuantity,
                          qtyFormProps: const QtyFormProps(enableTyping: false),

                          maxVal: 10, // todo - add stock quantity as max value
                          steps: 1,
                          minVal: 1,
                          onQtyChanged: (value) {
                            // todo - implement update cart API
                          },
                          decoration: QtyDecorationProps(
                            btnColor: Theme.of(context).primaryColor,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                            contentPadding: const EdgeInsets.all(2),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery by ${getDeliveryDate()}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text("$itemTotal ريال")
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductWidget2 extends StatelessWidget {
  const ProductWidget2({
    super.key,
  });

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
          Column(
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
                        text: "Mr. Abdul Malik",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    ]),
              ),
              const Gap(5),
              Text(
                "Customer Address, KSA",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                    ),
              )
            ],
          ),
          Material(
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
          )
        ],
      ),
    );
  }
}

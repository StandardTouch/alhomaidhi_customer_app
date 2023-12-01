import 'package:flutter/material.dart';

class SingleOrderCard extends StatelessWidget {
  var borderRadius = const BorderRadius.only(
    topRight: Radius.circular(10),
    bottomRight: Radius.circular(10),
    bottomLeft: Radius.circular(10),
    topLeft: Radius.circular(10),
  );
  SingleOrderCard({super.key});
//  https://alhomaidhigroup.com/wp-content/uploads/2023/11/dStvdWIxbkFadEYvNHJQem94SktpQT09.png
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: borderRadius),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(4),
            width: 82,
            height: 82,
            child: Image.network(
                "https://alhomaidhigroup.com/wp-content/uploads/2023/11/dStvdWIxbkFadEYvNHJQem94SktpQT09.png"),
          ),
          Container(
            width: double.infinity,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("title"), Text("Subtitle")],
            ),
          ),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );

    // return Container(
    //   height: 85,
    //   child: ListTile(
    //     trailing: Icon(Icons.arrow_forward_ios),
    //     tileColor: Colors.white,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: borderRadius,
    //       side: const BorderSide(
    //         width: 1,
    //         color: Colors.black,
    //       ),
    //     ),
    //     leading: Image.network(
    //       "https://alhomaidhigroup.com/wp-content/uploads/2023/11/dStvdWIxbkFadEYvNHJQem94SktpQT09.png",
    //       width: 82,
    //       height: 82,
    //     ),
    //     title: const Text("Delivered on Mon Oct 25"),
    //     subtitle: const Text("Calvin Klein  /  كلفين كلاين"),
    //   ),
    // );
  }
}

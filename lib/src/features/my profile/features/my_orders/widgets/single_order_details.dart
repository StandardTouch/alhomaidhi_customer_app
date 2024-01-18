import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SingleOrderDetails extends StatefulWidget {
  const SingleOrderDetails({
    super.key,
    required this.orderId,
    required this.productName,
    required this.productUrl,
    required this.productPrice,
    required this.orderStatus,
    required this.cusName,
    required this.deliveryAddress,
    required this.phoneNumber,
  });
  final String orderId;
  final String productName;
  final String productUrl;
  final String productPrice;
  final String orderStatus;
  final String cusName;
  final String deliveryAddress;
  final String phoneNumber;

  @override
  State<SingleOrderDetails> createState() => _SingleOrderDetailsState();
}

class _SingleOrderDetailsState extends State<SingleOrderDetails>
    with SingleTickerProviderStateMixin {
  final borderRadius = const BorderRadius.only(
    topRight: Radius.circular(10),
    bottomRight: Radius.circular(10),
    bottomLeft: Radius.circular(10),
    topLeft: Radius.circular(10),
  );

  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1), // Blinking speed
      vsync: this,
    )..repeat(reverse: true);
    _animation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Color> getOrderStatusColors(String status) {
    const defaultColor = Colors.grey;
    const activeColor = Color.fromARGB(255, 3, 104, 45);

    List<Color> colors = List.filled(4, defaultColor);

    switch (status) {
      case 'wc-processing':
        colors[0] = activeColor;
        break;

      case 'wc-order-approve':
        colors[0] = activeColor;
        colors[1] = activeColor;
        break;

      case 'wc-out-for-delivery':
        colors[0] = activeColor;
        colors[1] = activeColor;
        colors[2] = activeColor;
        break;
      case 'wc-completed':
        colors.fillRange(0, colors.length, activeColor); // All stages completed
        break;
    }
    return colors;
  }

  @override
  Widget build(BuildContext context) {
    List<Color> statusColors = getOrderStatusColors(widget.orderStatus);
    return ListView(
      children: [
        const Gap(20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerLeft,
          child: Text(
            widget.orderId,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            height: DeviceInfo.getDeviceHeight(context) * 0.13,
            width: DeviceInfo.getDeviceHeight(context) * 0.5,
            padding: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: Colors.grey)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: DeviceInfo.getDeviceWidth(context) * 0.73,
                              child: Text(widget.productName)),
                          SizedBox(
                            height: DeviceInfo.getDeviceHeight(context) * 0.02,
                          ),
                          Text(widget.productPrice)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        width: DeviceInfo.getDeviceWidth(context) * 0.2,
                        child: Image.network(
                          widget.productUrl,
                        ),
                      ),
                    )
                  ],
                ),
                // Gap(DeviceInfo.getDeviceHeight(context) * 0.015),
              ],
            )),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          height: DeviceInfo.getDeviceHeight(context) * 0.2,
          width: DeviceInfo.getDeviceHeight(context) * 0.5,
          padding: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(color: Colors.grey)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  FadeTransition(
                    opacity: widget.orderStatus == 'wc-processing'
                        ? _animation
                        : const AlwaysStoppedAnimation(2),
                    child: Icon(
                      Icons.check_circle,
                      color: statusColors[0],
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'Order Processing',
                    style: TextStyle(color: statusColors[0]),
                  )
                ],
              ),
              Row(
                children: [
                  FadeTransition(
                    opacity: widget.orderStatus == 'wc-order-approve'
                        ? _animation
                        : const AlwaysStoppedAnimation(2),
                    child: Icon(Icons.check_circle, color: statusColors[1]),
                  ),
                  const Gap(8),
                  Text('Order Confirmation',
                      style: TextStyle(color: statusColors[1]))
                ],
              ),
              Row(
                children: [
                  FadeTransition(
                      opacity: widget.orderStatus == 'wc-out-for-delivery'
                          ? _animation
                          : const AlwaysStoppedAnimation(2),
                      child: Icon(Icons.check_circle, color: statusColors[2])),
                  const Gap(8),
                  Text('Order Shipped',
                      style: TextStyle(color: statusColors[2]))
                ],
              ),
              Row(
                children: [
                  FadeTransition(
                      opacity: widget.orderStatus == 'wc-completed'
                          ? _animation
                          : const AlwaysStoppedAnimation(2),
                      child: Icon(Icons.check_circle, color: statusColors[3])),
                  const Gap(8),
                  Text('Order Delivered',
                      style: TextStyle(color: statusColors[3]))
                ],
              )
            ],
          ),
        ),
        Gap(DeviceInfo.getDeviceHeight(context) * 0.01),
        const Padding(
          padding: EdgeInsets.only(left: 14),
          child: Text('Shipping Information'),
        ),
        Gap(DeviceInfo.getDeviceHeight(context) * 0.01),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          height: DeviceInfo.getDeviceHeight(context) * 0.24,
          width: DeviceInfo.getDeviceHeight(context) * 0.5,
          padding: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(color: Colors.grey)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name:',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(widget.cusName),
              Text(
                'Phone:',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(widget.phoneNumber),
              Text(
                'Address:',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(widget.deliveryAddress)
            ],
          ),
        ),
      ],
    );
  }
}

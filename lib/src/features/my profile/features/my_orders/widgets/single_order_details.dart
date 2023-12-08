import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SingleOrderDetails extends StatelessWidget {
  SingleOrderDetails(
      {super.key,
      required this.orderId,
      required this.productName,
      required this.productUrl,
      required this.productPrice,
      required this.orderStatus,
      required this.cusName,
      required this.deliveryAddress});
  final orderId;
  final productName;
  final productUrl;
  final productPrice;
  final orderStatus;
  final cusName;
  final deliveryAddress;

  final borderRadius = const BorderRadius.only(
    topRight: Radius.circular(10),
    bottomRight: Radius.circular(10),
    bottomLeft: Radius.circular(10),
    topLeft: Radius.circular(10),
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
        Gap(20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerLeft,
          child: Text(
            'Order ID - ST023536464',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: DeviceInfo.getDeviceHeight(context) * 0.13,
            width: DeviceInfo.getDeviceHeight(context) * 0.5,
            padding: const EdgeInsets.only(left: 4),
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
                      child: Container(
                        // height: DeviceInfo.getDeviceWidth(context) * 0.1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width:
                                    DeviceInfo.getDeviceWidth(context) * 0.73,
                                child: Text(
                                    'Calvin Klein Watches / ساعات كلفين كلاين')),
                            Text('ر.س1,196.00')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        width: DeviceInfo.getDeviceWidth(context) * 0.2,
                        child: Image.network(
                          'https://alhomdelivery.standardtouch.com/wp-content/uploads/2023/09/cmenet-industry.png',
                        ),
                      ),
                    )
                  ],
                ),
                // Gap(DeviceInfo.getDeviceHeight(context) * 0.015),
              ],
            )),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: DeviceInfo.getDeviceHeight(context) * 0.2,
          width: DeviceInfo.getDeviceHeight(context) * 0.5,
          padding: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(color: Colors.grey)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle),
                  Gap(8),
                  Text('Order Placed')
                ],
              ),
              Row(
                children: [
                  Icon(Icons.check_circle),
                  Gap(8),
                  Text('Order Confrimation')
                ],
              ),
              Row(
                children: [
                  Icon(Icons.check_circle),
                  Gap(8),
                  Text('Order Shipped')
                ],
              ),
              Row(
                children: [
                  Icon(Icons.check_circle),
                  Gap(8),
                  Text('Order Delivered')
                ],
              )
            ],
          ),
        ),
        Gap(DeviceInfo.getDeviceHeight(context) * 0.01),
        Text('Shipping Information'),
        Gap(DeviceInfo.getDeviceHeight(context) * 0.01),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
              Text('Order Confirmation'),
              Text(
                'Phone:',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text('+91 ******4800'),
              Text(
                'Address:',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                  'Lorem ipsum dolor sit amet consectetur. Sed cras egestas aenean porttitor eu leo morbi nibh. At condimentum urna cursus eu.'),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: DeviceInfo.getDeviceHeight(context) * 0.045,
          width: DeviceInfo.getDeviceHeight(context) * 0.5,
          padding: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(color: Colors.grey)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.receipt),
              Text('Invoice Download'),
            ],
          ),
        ),
      ],
    );
  }
}

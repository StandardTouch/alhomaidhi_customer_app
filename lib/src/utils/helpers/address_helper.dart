import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/address/provider/address_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<Map<String, String>?> getAddressData(WidgetRef ref) async {
  String name;
  String address;
  String city;
  String country;
  final profileAdd = await ref.read(addressProvider.future);

  if (profileAdd.message!.lastName != "" &&
      profileAdd.message!.firstName != "" &&
      profileAdd.message!.address1 != "" &&
      profileAdd.message!.address2 != "" &&
      profileAdd.message!.city != "" &&
      profileAdd.message!.country != "") {
    name = "${profileAdd.message!.firstName!} ${profileAdd.message!.lastName!}";
    address =
        "${profileAdd.message!.address1!}, ${profileAdd.message!.address2!}";
    city = profileAdd.message!.city!;
    country = profileAdd.message!.country!;

    return {
      "name": name,
      "address": address,
      "city": city,
      "country": country,
    };
  } else {
    return null;
  }
}

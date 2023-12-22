import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_invoices/models/my_invoices_model.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/auth_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<MyInvoicesModel> getMyInvoices() async {
  final authDetails = await AuthHelper.getAuthDetails();
  try {
    final jsonResponse = await dioClientErp.get(APIEndpoints.getMyInvoice,
        options: Options(headers: {
          "Authorization": authDetails.token,
          "user_id": authDetails.userId,
        }),
        queryParameters: {
          "filtervalue0": authDetails.masterCustomerId,
          "access_token": dotenv.env["INVOICE_TOKEN"],
          "filterscount": 1,
          "filtertype0": "numericfilter",
          "filtercondition0": "EQUAL",
          "filterdatafield0": "customer.id",
          "skipOutletFiler": "true"
        });
    final response = MyInvoicesModel.fromJson(
      jsonResponse.data,
    );
    logger.i(jsonResponse.data["data"]["data"][0]["pdf_document"]);
    return response;
  } catch (err) {
    logger.e("Error from getMyOrders: $err");
    throw Exception("$err");
  }
}

import 'package:Alhomaidhi/src/features/my%20profile/features/my_invoices/models/my_invoices_model.dart';
import 'package:Alhomaidhi/src/utils/config/dio/dio_client.dart';
import 'package:Alhomaidhi/src/utils/constants/endpoints.dart';
import 'package:Alhomaidhi/src/utils/exceptions/homaidhi_exception.dart';
import 'package:Alhomaidhi/src/utils/helpers/auth_helper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<MyInvoicesModel> getMyInvoices() async {
  final authDetails = await AuthHelper.getAuthDetails();
  try {
    final jsonResponse = await dioClientErp.get(
      APIEndpoints.getMyInvoice,
      queryParameters: {
        "filtervalue0": authDetails.masterCustomerId,
        "access_token": dotenv.env["INVOICE_TOKEN"],
        "filterscount": 1,
        "filtertype0": "numericfilter",
        "filtercondition0": "EQUAL",
        "filterdatafield0": "customer.id",
        "skipOutletFiler": "true"
      },
    );
    MyInvoicesModel response;

    if (jsonResponse.data["data"]["data"].length == 0) {
      throw HomaidhiException(status: "APP303", message: "No invoices found");
    }
    response = MyInvoicesModel.fromJson(
      jsonResponse.data,
    );
    logger.i(jsonResponse.data["data"]["data"][0]["pdf_document"]);
    return response;
  } catch (err) {
    logger.e("Error from getMyInvoices: $err");
    if (err is HomaidhiException) {
      throw HomaidhiException(status: err.status, message: err.message);
    }
    throw Exception("$err");
  }
}

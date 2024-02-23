import 'package:Alhomaidhi/src/features/my%20profile/features/my_invoices/models/my_invoices_model.dart';
import 'package:Alhomaidhi/src/features/my%20profile/features/my_invoices/services/my_invoice_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myInvoicesProvider = FutureProvider<MyInvoicesModel>((ref) async {
  MyInvoicesModel response = await getMyInvoices();
  return response;
});

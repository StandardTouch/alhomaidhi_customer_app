import 'package:Alhomaidhi/src/features/my%20profile/features/my_invoices/providers/my_invoices_provider.dart';
import 'package:Alhomaidhi/src/features/my%20profile/features/my_invoices/widgets/my_invoice.dart';
import 'package:Alhomaidhi/src/utils/exceptions/homaidhi_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyInvoicesScreen extends ConsumerWidget {
  const MyInvoicesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myinvoices = ref.watch(myInvoicesProvider);
    return myinvoices.when(
      data: (data) {
        if (data.status == "success") {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Invoices'),
              backgroundColor: Colors.transparent,
            ),
            body: Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: data.data!.data!.length,
                  itemBuilder: (context, index) {
                    final int invoiceId =
                        data.data!.data![index].salesReceiptsDefsId!;
                    String stringInvoiceId = invoiceId.toString();
                    final String invoicePdf =
                        data.data!.data![index].pdfDocument!;
                    return MyInvoice(
                      invoiceId: stringInvoiceId,
                      invoicePdf: invoicePdf,
                    );
                  },
                )),
          );
        } else {
          return Center(
            child: Text(data.errorMessage ?? 'Unknown error'),
          );
        }
      },
      error: (err, stk) {
        if (err is HomaidhiException) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("My Invoices"),
            ),
            body: Center(
              child: Text(
                err.message,
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          return Scaffold(
              appBar: AppBar(
                title: const Text("My Invoices"),
              ),
              body: Center(
                  child: Text(
                "$err",
                textAlign: TextAlign.center,
              )));
        }
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}

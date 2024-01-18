// ignore_for_file: no_leading_underscores_for_local_identifiers

class MyInvoicesModel {
  String? status;
  Data? data;
  String? errorMessage;
  MyInvoicesModel({this.status, this.data, this.errorMessage});

  MyInvoicesModel.fromJson(Map<String, dynamic> json) {
    if (json["status"] is String) {
      status = json["status"];
    }

    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  List<Data1>? data;
  int? totalRows;

  Data({this.data, this.totalRows});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => Data1.fromJson(e)).toList();
    }
    if (json["totalRows"] is int) {
      totalRows = json["totalRows"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["totalRows"] = totalRows;
    return _data;
  }
}

class Data1 {
  int? salesReceiptsDefsId;
  String? salesReceiptsDefsDocnum;
  String? customerName;
  String? customerNameAlt;
  String? customerNationalityNo;
  int? customerId;
  String? customerBranch;
  String? salesReceiptsDefsDate;
  String? salesReceiptsDefsStatus;
  String? salesReceiptsDefsPostStatus;
  String? valLocationsName;
  String? valPaymentMethodsName;
  dynamic valPaymentMethodsNameAlt;
  String? finAccountsName;
  String? finAccountsNameAlt;
  dynamic salesPerson;
  String? salesReceiptsDefsMemo;
  String? salesReceiptsDefsDeposited;
  String? salesReceiptsDefsSubtotal;
  String? salesReceiptsDefsTotal;
  String? salesReceiptsDefsTotalWithoutTax;
  String? salesReceiptsDefsTotalTax;
  dynamic returnsReturnsRef;
  String? returnsTotal;
  String? outletMasterName;
  dynamic counterId;
  dynamic posDocnum;
  int? valtranstypesId;
  String? companyBranchMasterName;
  int? formmasterId;
  int? typedefsId;
  String? pdfUserId;
  String? pdfPrintTemplate;
  String? pdfDocument;
  String? companyBranchMasterCode;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  dynamic salesReceiptsDefsCustomerNumber;

  Data1(
      {this.salesReceiptsDefsId,
      this.salesReceiptsDefsDocnum,
      this.customerName,
      this.customerNameAlt,
      this.customerNationalityNo,
      this.customerId,
      this.customerBranch,
      this.salesReceiptsDefsDate,
      this.salesReceiptsDefsStatus,
      this.salesReceiptsDefsPostStatus,
      this.valLocationsName,
      this.valPaymentMethodsName,
      this.valPaymentMethodsNameAlt,
      this.finAccountsName,
      this.finAccountsNameAlt,
      this.salesPerson,
      this.salesReceiptsDefsMemo,
      this.salesReceiptsDefsDeposited,
      this.salesReceiptsDefsSubtotal,
      this.salesReceiptsDefsTotal,
      this.salesReceiptsDefsTotalWithoutTax,
      this.salesReceiptsDefsTotalTax,
      this.returnsReturnsRef,
      this.returnsTotal,
      this.outletMasterName,
      this.counterId,
      this.posDocnum,
      this.valtranstypesId,
      this.companyBranchMasterName,
      this.formmasterId,
      this.typedefsId,
      this.pdfUserId,
      this.pdfPrintTemplate,
      this.pdfDocument,
      this.companyBranchMasterCode,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.salesReceiptsDefsCustomerNumber});

  Data1.fromJson(Map<String, dynamic> json) {
    if (json["sales_receipts_defs.id"] is int) {
      salesReceiptsDefsId = json["sales_receipts_defs.id"];
    }
    if (json["sales_receipts_defs.docnum"] is String) {
      salesReceiptsDefsDocnum = json["sales_receipts_defs.docnum"];
    }
    if (json["customer.name"] is String) {
      customerName = json["customer.name"];
    }
    if (json["customer_name_alt"] is String) {
      customerNameAlt = json["customer_name_alt"];
    }
    if (json["customer.nationality_no"] is String) {
      customerNationalityNo = json["customer.nationality_no"];
    }
    if (json["customer.id"] is int) {
      customerId = json["customer.id"];
    }
    if (json["customer_branch"] is String) {
      customerBranch = json["customer_branch"];
    }
    if (json["sales_receipts_defs.date"] is String) {
      salesReceiptsDefsDate = json["sales_receipts_defs.date"];
    }
    if (json["sales_receipts_defs.status"] is String) {
      salesReceiptsDefsStatus = json["sales_receipts_defs.status"];
    }
    if (json["sales_receipts_defs.post_status"] is String) {
      salesReceiptsDefsPostStatus = json["sales_receipts_defs.post_status"];
    }
    if (json["val_locations.name"] is String) {
      valLocationsName = json["val_locations.name"];
    }
    if (json["val_payment_methods.name"] is String) {
      valPaymentMethodsName = json["val_payment_methods.name"];
    }
    valPaymentMethodsNameAlt = json["val_payment_methods.name_alt"];
    if (json["fin_accounts.name"] is String) {
      finAccountsName = json["fin_accounts.name"];
    }
    if (json["fin_accounts.name_alt"] is String) {
      finAccountsNameAlt = json["fin_accounts.name_alt"];
    }
    salesPerson = json["sales_person"];
    if (json["sales_receipts_defs.memo"] is String) {
      salesReceiptsDefsMemo = json["sales_receipts_defs.memo"];
    }
    if (json["sales_receipts_defs.deposited"] is String) {
      salesReceiptsDefsDeposited = json["sales_receipts_defs.deposited"];
    }
    if (json["sales_receipts_defs.subtotal"] is String) {
      salesReceiptsDefsSubtotal = json["sales_receipts_defs.subtotal"];
    }
    if (json["sales_receipts_defs.total"] is String) {
      salesReceiptsDefsTotal = json["sales_receipts_defs.total"];
    }
    if (json["sales_receipts_defs.total_without_tax"] is String) {
      salesReceiptsDefsTotalWithoutTax =
          json["sales_receipts_defs.total_without_tax"];
    }
    if (json["sales_receipts_defs.total_tax"] is String) {
      salesReceiptsDefsTotalTax = json["sales_receipts_defs.total_tax"];
    }
    returnsReturnsRef = json["returns.returns_ref"];
    if (json["returns.total"] is String) {
      returnsTotal = json["returns.total"];
    }
    if (json["outlet_master.name"] is String) {
      outletMasterName = json["outlet_master.name"];
    }
    counterId = json["counter_id"];
    posDocnum = json["pos_docnum"];
    if (json["valtranstypes_id"] is int) {
      valtranstypesId = json["valtranstypes_id"];
    }
    if (json["company_branch_master.name"] is String) {
      companyBranchMasterName = json["company_branch_master.name"];
    }
    if (json["formmaster_id"] is int) {
      formmasterId = json["formmaster_id"];
    }
    if (json["typedefs_id"] is int) {
      typedefsId = json["typedefs_id"];
    }
    if (json["pdf_user_id"] is String) {
      pdfUserId = json["pdf_user_id"];
    }
    if (json["pdf_print_template"] is String) {
      pdfPrintTemplate = json["pdf_print_template"];
    }
    if (json["pdf_document"] is String) {
      pdfDocument = json["pdf_document"];
    }
    if (json["company_branch_master.code"] is String) {
      companyBranchMasterCode = json["company_branch_master.code"];
    }
    if (json["created_by"] is String) {
      createdBy = json["created_by"];
    }
    if (json["updated_by"] is String) {
      updatedBy = json["updated_by"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
    salesReceiptsDefsCustomerNumber =
        json["sales_receipts_defs.customer_number"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["sales_receipts_defs.id"] = salesReceiptsDefsId;
    _data["sales_receipts_defs.docnum"] = salesReceiptsDefsDocnum;
    _data["customer.name"] = customerName;
    _data["customer_name_alt"] = customerNameAlt;
    _data["customer.nationality_no"] = customerNationalityNo;
    _data["customer.id"] = customerId;
    _data["customer_branch"] = customerBranch;
    _data["sales_receipts_defs.date"] = salesReceiptsDefsDate;
    _data["sales_receipts_defs.status"] = salesReceiptsDefsStatus;
    _data["sales_receipts_defs.post_status"] = salesReceiptsDefsPostStatus;
    _data["val_locations.name"] = valLocationsName;
    _data["val_payment_methods.name"] = valPaymentMethodsName;
    _data["val_payment_methods.name_alt"] = valPaymentMethodsNameAlt;
    _data["fin_accounts.name"] = finAccountsName;
    _data["fin_accounts.name_alt"] = finAccountsNameAlt;
    _data["sales_person"] = salesPerson;
    _data["sales_receipts_defs.memo"] = salesReceiptsDefsMemo;
    _data["sales_receipts_defs.deposited"] = salesReceiptsDefsDeposited;
    _data["sales_receipts_defs.subtotal"] = salesReceiptsDefsSubtotal;
    _data["sales_receipts_defs.total"] = salesReceiptsDefsTotal;
    _data["sales_receipts_defs.total_without_tax"] =
        salesReceiptsDefsTotalWithoutTax;
    _data["sales_receipts_defs.total_tax"] = salesReceiptsDefsTotalTax;
    _data["returns.returns_ref"] = returnsReturnsRef;
    _data["returns.total"] = returnsTotal;
    _data["outlet_master.name"] = outletMasterName;
    _data["counter_id"] = counterId;
    _data["pos_docnum"] = posDocnum;
    _data["valtranstypes_id"] = valtranstypesId;
    _data["company_branch_master.name"] = companyBranchMasterName;
    _data["formmaster_id"] = formmasterId;
    _data["typedefs_id"] = typedefsId;
    _data["pdf_user_id"] = pdfUserId;
    _data["pdf_print_template"] = pdfPrintTemplate;
    _data["pdf_document"] = pdfDocument;
    _data["company_branch_master.code"] = companyBranchMasterCode;
    _data["created_by"] = createdBy;
    _data["updated_by"] = updatedBy;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["sales_receipts_defs.customer_number"] =
        salesReceiptsDefsCustomerNumber;
    return _data;
  }
}

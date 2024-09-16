import 'dart:convert';

class TransactionModel {
  final int id;
  final int? paymentSourceId;
  final String paymentSourceName;
  final int assUserSavingId;
  final String? adminName;
  final String reference;
  final String description;
  final String amount;
  final String sourceName;
  final String sourceId;
  final String currency;
  final String fees;
  final String amountCurrency;
  final String balanceAfter;
  final String paymentType;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic> descriptionJson;

  TransactionModel({
    required this.id,
    required this.paymentSourceId,
    required this.paymentSourceName,
    required this.assUserSavingId,
    this.adminName,
    required this.reference,
    required this.description,
    required this.amount,
    required this.sourceName,
    required this.sourceId,
    required this.currency,
    required this.fees,
    required this.amountCurrency,
    required this.balanceAfter,
    required this.paymentType,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.descriptionJson,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      paymentSourceId: json['payment_source_id'],
      paymentSourceName: json['payment_source_name'],
      assUserSavingId: json['ass_user_saving_id'],
      adminName: json['admin_name'],
      reference: json['reference'],
      description: json['description'],
      amount: json['amount'],
      sourceName: json['source_name'],
      sourceId: json['source_id'],
      currency: json['currency'],
      fees: json['fees'],
      amountCurrency: json['amount_currency'],
      balanceAfter: json['balance_after'],
      paymentType: json['payment_type'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      descriptionJson: jsonDecode(json['description_json']),
    );
  }
}

class PaymentResponse {
  final List<TransactionModel> payments;
  final int total;
  final int currentPage;
  final bool hasMorePages;
  final int firstPage;
  final int lastPage;
  final bool isEmpty;

  PaymentResponse({
    required this.payments,
    required this.total,
    required this.currentPage,
    required this.hasMorePages,
    required this.firstPage,
    required this.lastPage,
    required this.isEmpty,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    var list = json['payments'] as List;
    List<TransactionModel> paymentsList =
        list.map((i) => TransactionModel.fromJson(i)).toList();

    return PaymentResponse(
      payments: paymentsList,
      total: json['total'],
      currentPage: json['current_page'],
      hasMorePages: json['has_more_pages'],
      firstPage: json['first_page'],
      lastPage: json['last_page'],
      isEmpty: json['is_empty'],
    );
  }
}

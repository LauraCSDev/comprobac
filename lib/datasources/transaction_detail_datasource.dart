import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/transaction_detail_model.dart';

/// Fuente de datos para transacciones bancarias desde un archivo local JSON extendido.
class TransactionDetailDataSource {
  /// Obtiene la lista de transacciones detalladas desde el asset local.
  Future<List<TransactionDetailModel>> fetchTransactions() async {
    final String response = await rootBundle.loadString('assets/transactions.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => TransactionDetailModel.fromJson(json)).toList();
  }

  /// Busca una transacción detallada por referencia, cuenta y fecha.
  Future<TransactionDetailModel?> findTransaction({
    required String reference,
    required String accountNumber,
    required String date,
  }) async {
    final transactions = await fetchTransactions();
    try {
      return transactions.firstWhere(
        (t) => t.reference == reference && t.accountNumber == accountNumber && t.date == date,
      );
    } catch (e) {
      return null;
    }
  }
}

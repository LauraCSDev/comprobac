import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasources/transaction_detail_datasource.dart';
import '../models/transaction_detail_model.dart';

/// Provider para el resultado de la validación de la transacción.

/// Provider para los parámetros de validación de la transacción.
final transactionValidationParamsProvider = StateProvider<({String reference, String accountNumber, String date})?>((ref) => null);

/// Provider para el resultado de la validación de la transacción.
final transactionDetailProvider = FutureProvider.autoDispose<TransactionDetailModel?>((ref) async {
  final params = ref.watch(transactionValidationParamsProvider);
  if (params == null) return null;
  return await TransactionDetailDataSource().findTransaction(
    reference: params.reference,
    accountNumber: params.accountNumber,
    date: params.date,
  );
});

final selectedTransactionProvider = StateProvider<TransactionDetailModel?>((ref) => null);

/// Provider para el resultado de validación SINPE Móvil.
/// isValid: si los primeros 8 dígitos coinciden con la fecha.
/// entityCode: los 3 dígitos siguientes (código de entidad financiera).
final sinpeMovilResultProvider = StateProvider<({bool isValid, String entityCode})?>((ref) => null);

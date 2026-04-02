import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/transaction_detail_model.dart';

final selectedTransactionProvider = StateProvider<TransactionDetailModel?>((ref) => null);

/// Provider para el resultado de validación SINPE Móvil.
/// isValid: si los primeros 8 dígitos coinciden con la fecha.
/// entityCode: los 3 dígitos siguientes (código de entidad financiera).
/// errorMessage: mensaje de error específico cuando isValid es false.
final sinpeMovilResultProvider = StateProvider<({bool isValid, String entityCode, String errorMessage})?>((ref) => null);

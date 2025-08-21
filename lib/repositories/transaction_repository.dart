import '../datasources/datasources.dart';

/// Repositorio para operaciones de transacciones bancarias.
class TransactionRepository {
  final TransactionDetailDataSource dataSource;

  /// Crea un repositorio de transacciones con un [dataSource].
  TransactionRepository(this.dataSource);

  /// Valida si existe una transacción con los datos dados.
  Future<bool> validateTransaction({
    required String reference,
    required String accountNumber,
    required String date,
  }) async {
    final transactions = await dataSource.fetchTransactions();
    return transactions.any((t) => t.reference == reference && t.accountNumber == accountNumber && t.date == date);
  }
}
